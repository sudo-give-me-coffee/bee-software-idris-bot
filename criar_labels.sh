

curl -f -X POST https://api.github.com/repos/$USERNAME/$REPO/labels -H "Authorization: token $(cat $GH_TOKEN_PATH)" -d '{"name":": feat","color":"1d76db"}'
