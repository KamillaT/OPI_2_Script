
#!/bin/bash

rm -rf buffer
mkdir buffer
git init buffer
cd buffer

git checkout -b master
sh ../Red.sh
cp ../commit0/* . && git add .
git commit -m "r0"

git checkout -b vetka1
cp ../commit1/* . && git add .
git commit -m "r1"

sh ../Blue.sh
git checkout -b blueVetkaR2
cp ../commit2/* . && git add .
git commit -m "r2"

git checkout -b blueVetkaR3
cp ../commit3/* . && git add .
git commit -m "r3"

git checkout -b blueVetkaR4
cp ../commit4/* . && git add .
git commit -m "r4"

sh ../Red.sh
git checkout master
cp ../commit5/* . && git add .
git commit -m "r5"

git checkout -b vetka2
cp ../commit6/* . && git add .
git commit -m "r6"

sh ../Blue.sh
git checkout blueVetkaR2
cp ../commit7/* . && git add .
git commit -m "r7"
cp ../commit8/* . && git add .
git commit -m "r8"

git checkout blueVetkaR4
cp ../commit9/* . && git add .
git commit -m "r9"

sh ../Red.sh
git checkout master
cp ../commit10/* . && git add .
git commit -m "r10"

sh ../Blue.sh
git checkout blueVetkaR2
cp ../commit11/* . && git add .
git commit -m "r11"

sh ../Red.sh
git checkout vetka1
cp ../commit12/* . && git add .
git commit -m "r12"
cp ../commit13/* . && git add .
git commit -m "r13"

sh ../Blue.sh
git checkout blueVetkaR2
cp ../commit14/* . && git add .
git commit -m "r14"
cp ../commit15/* . && git add .
git commit -m "r15"

sh ../Red.sh
git checkout vetka2
cp ../commit16/* . && git add .
git commit -m "r16"

git checkout vetka1
cp ../commit17/* . && git add .
git commit -m "r17"

git checkout vetka2
cp ../commit18/* . && git add .
git commit -m "r18"

git checkout master
cp ../commit19/* . && git add .
git commit -m "r19"

git checkout vetka1
cp ../commit20/* . && git add .
git commit -m "r20"

sh ../Blue.sh
git checkout blueVetkaR2
cp ../commit21/* . && git add .
git commit -m "r21"
cp ../commit22/* . && git add .
git commit -m "r22"

sh ../Red.sh
git checkout master
cp ../commit23/* . && git add .
git commit -m "r23"

git checkout vetka1
cp ../commit24/* . && git add .
git commit -m "r24"

git checkout vetka2
git merge -X ours vetka1 -m "合并，使用 ours 策略解决 vetka1"
cp ../commit25/* . && git add .
git commit -m "r25"

sh ../Blue.sh
git checkout blueVetkaR2
cp ../commit26/* . && git add .
git commit -m "r26"
cp ../commit27/* . && git add .
git commit -m "r27"

git checkout blueVetkaR4
git merge -X theirs blueVetkaR2 -m "合并，使用 theirs 策略解决 blueVetkaR2"
cp ../commit28/* . && git add .
git commit -m "r28"

sh ../Red.sh
git checkout blueVetkaR3
cp ../commit31/* . && git add .
git commit -m "r31"

git checkout vetka2
git merge blueVetkaR3 -m "合并，手动解决冲突" || {
    echo "冲突：手动解决"
    cp ../commit32/* . && git add .
    git commit -m "r32"
}

sh ../Blue.sh
git checkout blueVetkaR4
git merge vetka2 -m "合并，仅保留 ours 中的 Lab4.java（blueVetkaR4）" || {
    echo "冲突：采用 commit33 的数据"
    git checkout --ours Lab4.java
    git add Lab4.java
    git commit -m "r33"
}

sh ../Red.sh
git checkout master
commit33_hash=$(git rev-parse blueVetkaR4)
git cherry-pick -m 1 "$commit33_hash" || {
    echo "冲突：采用 commit34 的数据"
    cp ../commit34/* . && git add .
    git cherry-pick --continue
}
git commit --allow-empty -m "r34：通过 cherry-pick 合并 blueVetkaR4 的最后一个提交"

git merge --strategy=ours --no-commit blueVetkaR4
git commit --allow-empty -m "嗨 r34"
