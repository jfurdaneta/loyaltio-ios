#!/bin/bash
#
# (Above line comes out when placing in Xcode scheme)
#


############################################################################

HOCKEYAPP_API_TOKEN= #"5aba4caaef6e475984ae6c6c66163020"

URL="https://rink.hockeyapp.net/api/2/apps/upload"

############################################################################

TESTFAIRY_APPID="704a561d15dd1e3e5acef3021b3ad18425278b63"

#silen08620-> apiSDK:    a1bb73b19e2fbf4ca0aa412d83dfdb1509d2998c
#silen08620-> apiUpload: 704a561d15dd1e3e5acef3021b3ad18425278b63


TESTES_FAIRY_GROUP="Qbit"

############################################################################

# Name of Proyect
#

cd ..
AUX_FOLDER="build"

PROYECT_NAME="Qbit"
SCHEME_NAME="Qbit"

WORKSPACE=$PROYECT_NAME".xcworkspace"
ARCHIVE_NAME=$PROYECT_NAME".xcarchive"

OBJROOT_NAME=$PWD"/"$AUX_FOLDER
SYMROOT_NAME=$PWD"/"$AUX_FOLDER
ARCHIVE_PATH=$PWD"/"$AUX_FOLDER"/"$ARCHIVE_NAME

IPA_PATH=$PWD"/"$AUX_FOLDER
IPA_PATH_NAME=$PWD"/"$AUX_FOLDER"/"$PROYECT_NAME".ipa"

OPTION_PLIST=$PWD"/"$PROYECT_NAME"/exportOptions.plist"

############################################################################
# FUNCTIONS

sendByHockeyApp(){

    UPLOAD_SUCCESS=0
    INSTALL_URL="Unkown"


    HOCKEYAPP_RESPONSE=$(curl "${URL}" \
    -F status=2 \
    -F notify=1 \
    -F notes="${NOTES}" \
    -F notes_type=0 \
    -F ipa=@$IPA_PATH_NAME \
    -F dsym=@$DSYM_ZIP \
    -F commit_sha=$SHA \
    -H "X-HockeyAppToken: ${HOCKEYAPP_API_TOKEN}")

    echo Upload API HTTP Response: ${HOCKEYAPP_RESPONSE}

    if [ $HOCKEYAPP_RESPONSE ]; then
        UPLOAD_SUCCESS=1
        INSTALL_URL=$(echo $HOCKEYAPP_RESPONSE | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["public_url"]')
    fi

}



sendByTestFairy(){

    sh scripts/testfairy-upload-ios.sh $IPA_PATH_NAME $TESTFAIRY_APPID $TESTES_FAIRY_GROUP
}

executeArchive(){

    xcodebuild -workspace $WORKSPACE -scheme $SCHEME_NAME -sdk iphoneos -configuration AdHocDistribution archive -archivePath $ARCHIVE_PATH
}

createIPA(){

    xcodebuild -exportArchive -archivePath $ARCHIVE_PATH -exportOptionsPlist $OPTION_PLIST -exportPath $IPA_PATH
}

############################################################################
# begin script

  executeArchive
    createIPA

    if [[ -n $TESTFAIRY_APPID ]]; then
        sendByTestFairy
        echo "."
    fi

    if [[ -n $HOCKEYAPP_API_TOKEN ]]; then
        sendByHockeyApp
        echo "."
    fi



