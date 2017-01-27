#!/bin/bash


Cyan='\033[0;36m'
Default='\033[0;m'

author=""
projectName=""
httpsRepo=""
sshRepo=""
homePage=""
confirmed="n"
organizationName=""

getAuthor() {
    read -p "请输入作者名: " author

    if test -z "$author"; then
        getAuthor
    fi
}

getProjectName() {
    read -p "请输入项目名: " projectName

    if test -z "$projectName"; then
        getProjectName
    fi
}

getOrganizationName() {
    read -p "请输入组织名: " organizationName

    if test -z "$organizationName"; then
        getOrganizationName
    fi
}

getHTTPSRepo() {
    read -p "请输入仓库HTTPS URL: " httpsRepo

    if test -z "$httpsRepo"; then
        getHTTPSRepo
    fi
}

getSSHRepo() {
    read -p "请输入仓库SSH URL: " sshRepo

    if test -z "$sshRepo"; then
        getSSHRepo
    fi
}

getHomePage() {
    read -p "请输入主页 URL: " homePage

    if test -z "$homePage"; then
        getHomePage
    fi
}

getInfomation() {
    getAuthor
    getProjectName
    getOrganizationName
    getHTTPSRepo
    getSSHRepo
    getHomePage

    echo -e "\n${Default}================================================"
    echo -e "  Author             :  ${Cyan}${author}${Default}"
    echo -e "  Project Name       :  ${Cyan}${projectName}${Default}"
    echo -e "  Organization Name  :  ${Cyan}${organizationName}${Default}"
    echo -e "  HTTPS Repo         :  ${Cyan}${httpsRepo}${Default}"
    echo -e "  SSH Repo           :  ${Cyan}${sshRepo}${Default}"
    echo -e "  Home Page URL      :  ${Cyan}${homePage}${Default}"
    echo -e "================================================\n"
}

echo -e "\n"
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
    if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
        getInfomation
    fi
    read -p "确定? (y/n):" confirmed
done

cp -r "./Temp" "../${projectName}"
mv "../${projectName}/Temp" "../${projectName}/${projectName}"
mv "../${projectName}/${projectName}/Temp" "../${projectName}/${projectName}/${projectName}"
mv "../${projectName}/Temp.xcodeproj" "../${projectName}/${projectName}.xcodeproj"


licenseFilePath="../${projectName}/FILE_LICENSE"
gitignoreFilePath="../${projectName}/.gitignore"
specFilePath="../${projectName}/${projectName}.podspec"
readmeFilePath="../${projectName}/readme.md"
uploadFilePath="../${projectName}/upload.sh"
podfilePath="../${projectName}/Podfile"
pbxprojPath="../${projectName}/${projectName}.xcodeproj/project.pbxproj"
xcworkspacedataPath="../${projectName}/${projectName}.xcodeproj/project.xcworkspace/contents.xcworkspacedata"

echo "copy to $licenseFilePath"
cp -f ./templates_category/FILE_LICENSE "$licenseFilePath"
echo "copy to $gitignoreFilePath"
cp -f ./templates_category/gitignore    "$gitignoreFilePath"
echo "copy to $specFilePath"
cp -f ./templates_category/pod.podspec  "$specFilePath"
echo "copy to $readmeFilePath"
cp -f ./templates_category/readme.md    "$readmeFilePath"
echo "copy to $uploadFilePath"
cp -f ./templates_category/upload.sh    "$uploadFilePath"
echo "copy to $podfilePath"
cp -f ./templates_category/Podfile      "$podfilePath"

echo "editing..."
sed -i "" "s%__ProjectName__%${projectName}%g" "$gitignoreFilePath"
sed -i "" "s%__ProjectName__%${projectName}%g" "$readmeFilePath"
sed -i "" "s%__ProjectName__%${projectName}%g" "$uploadFilePath"
sed -i "" "s%__ProjectName__%${projectName}%g" "$podfilePath"

sed -i "" "s%__ProjectName__%${projectName}%g" "$specFilePath"
sed -i "" "s%__Author__%${author}%g" "$specFilePath"
sed -i "" "s%__HomePage__%${homePage}%g"      "$specFilePath"
sed -i "" "s%__SSHRepo__%${sshRepo}%g"    "$specFilePath"
sed -i "" "s%__SSHRepo__%${sshRepo}%g"    "$podfilePath"

sed -i "" "s%__ProjectName__%${projectName}%g" "$xcworkspacedataPath"

sed -i "" "s%__ProjectName__%${projectName}%g" "$pbxprojPath"
sed -i "" "s%__OrganizationName__%${organizationName}%g" "$pbxprojPath"

echo "edit finished"

echo "cleaning..."
cd ../$projectName
git init
git remote add origin $sshRepo  &> /dev/null
git rm -rf --cached ./Pods/     &> /dev/null
git rm --cached Podfile.lock    &> /dev/null
git rm --cached .DS_Store       &> /dev/null
git rm -rf --cached $projectName.xcworkspace/           &> /dev/null
git rm -rf --cached $projectName.xcodeproj/xcuserdata/`whoami`.xcuserdatad/xcschemes/$projectName.xcscheme &> /dev/null
git rm -rf --cached $projectName.xcodeproj/project.xcworkspace/xcuserdata/ &> /dev/null
echo "clean finished"
say "finished"
echo "finished"
