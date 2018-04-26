bash

title=boostread
workpath=~/work/rails
work=$workpath/$title

# rails new $title

cd $work

git init
git add .
git commit -m "Initial commit."

rails generate controller StaticPages home
