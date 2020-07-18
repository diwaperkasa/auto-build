#!/bin/bash
echo '--- --- --- --- --- --- --- --- --- --- ---'
echo 'Deploying site...'

branch=$(git rev-parse --abbrev-ref HEAD)

if [ "Production" == "$branch" ]; then
    pathHtml='your-project-directory'
    # Production Branch
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    gitStatus=$(git --work-tree=$pathHtml rev-parse $branch)

    git --work-tree=$pathHtml pull

    repoStatus=$(git --work-tree=$pathHtml rev-parse $branch)

    if [ $gitStatus == $repoStatus ]; then
        exit 1
    fi

    #create your pipe line here!

    echo '--- --- --- --- --- --- --- --- --- --- ---'
    echo 'NPM install'
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    npm install --prefix $pathHtml
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    echo 'NPM build'
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    npm run build --prefix $pathHtml
elif [ "Development" == "$branch" ]; then
    pathHtml='your-project-directory'
    # Development / Testing Branch 
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    gitStatus=$(git --work-tree=$pathHtml rev-parse $branch)

    git --work-tree=$pathHtml pull

    repoStatus=$(git --work-tree=$pathHtml rev-parse $branch)

    if [ $gitStatus == $repoStatus ]; then
        exit 1
    fi

    #create your pipe line here!

    echo '--- --- --- --- --- --- --- --- --- --- ---'
    echo 'NPM install'
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    npm install --prefix $pathHtml
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    echo 'NPM build'
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    npm run build --prefix $pathHtml
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    echo 'copy .htaccess to public folder'
    echo '--- --- --- --- --- --- --- --- --- --- ---'
    cp $pathHtml/.htaccess $pathHtml/build
fi

echo '--- --- --- --- --- --- --- --- --- --- ---'
echo 'Done'
echo '--- --- --- --- --- --- --- --- --- --- ---'
