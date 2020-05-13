# Increase the version of 'pubspec.yaml'
# Use sh incr-version.sh [--major|--minor]

FULL_VERSION=$(cat pubspec.yaml | awk '/^version:/ {print $2}')
VERSION_NAME=$(echo $FULL_VERSION | awk -F + '{print $1}')
VERSION_NUMBER=$(echo $FULL_VERSION | awk -F + '{print $2}')
MAJOR_NUM=$(echo $VERSION_NAME | awk -F . '{print $1}')
MINOR_NUM=$(echo $VERSION_NAME | awk -F . '{print $2}')
PATCH_NUM=$(echo $VERSION_NAME | awk -F . '{print $3}')

NEXT_VERSION_NUMBER=$(expr $VERSION_NUMBER + 1)
NEXT_VERSION_NAME=$VERSION_NAME

if [[ $1 == '--major' ]]; then
    NEXT_NUM=$(expr $MAJOR_NUM + 1)
    NEXT_VERSION_NAME="$NEXT_NUM.0.0"
elif [[ $1 == '--minor' ]]; then
    NEXT_NUM=$(expr $MINOR_NUM + 1)
    NEXT_VERSION_NAME="$MAJOR_NUM.$NEXT_NUM.0"
else
    NEXT_NUM=$(expr $PATCH_NUM + 1)
    NEXT_VERSION_NAME="$MAJOR_NUM.$MINOR_NUM.$NEXT_NUM"
fi

NEXT_FULL_VERSION="$NEXT_VERSION_NAME+$NEXT_VERSION_NUMBER"
echo "New version: $NEXT_FULL_VERSION"
sed -i'.bak' "s/^version: [[:digit:]][[:digit:]]*.[[:digit:]][[:digit:]]*.[[:digit:]][[:digit:]]*+[[:digit:]][[:digit:]]*$/version: $NEXT_FULL_VERSION/g" pubspec.yaml
rm pubspec.yaml.bak

