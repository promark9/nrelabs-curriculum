
git fetch origin master

echo $(git branch)
echo $(cat .git/HEAD)

# # Exit if the master branch is detected. This isn't a pull request
# # and we don't need a CHANGELOG update
# if [[ $(git branch | grep master) ]]; then
#     exit 0
# fi

echo "ENV TO FOLLOW"
echo $(env)


if [ "$GITHUB_EVENT_NAME" != "pull_request" ];
then
  echo "This is not a pull request, skipping the changelog check"
  exit 0
fi

echo "Detecting changes..."
echo $(git diff --name-only $(git rev-parse FETCH_HEAD))

if echo $(git diff --name-only $(git rev-parse FETCH_HEAD)) | grep -w CHANGELOG.md > /dev/null; then
    echo "Thanks for making a CHANGELOG update!"
    exit 0
else
    echo "No CHANGELOG update found. Please provide update to CHANGELOG for this change."
    exit 1
fi
