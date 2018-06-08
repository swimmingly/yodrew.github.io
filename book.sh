#!/bin/bash
# from ~/Dropbox/write/darkness

# collect images
cd img
rsync -auv title_page.png ../darkroomretreat/manuscript/images
rsync -auv photo/*.jpg ../darkroomretreat/manuscript/images
rsync -auv plan/[^ZY]*.png ../darkroomretreat/manuscript/images
# text
  # collect
cd ../yodrew.github.io/_pages
cp blurb.md notes.md foreword.md preface.md introduction.md hygiene.md format.md protocol.md prepare.md design.md make.md air.md darkness.md water.md appendix-laws-of-life.md appendix-pathology.md faq.md about/bibliography-influences.md about/acknowledgments.md about/services.md about/license.md about/bio.md ../../darkroomretreat/manuscript
  # YAML
cd ../../darkroomretreat/manuscript
perl -p -i -e 's,---\n,,s' *.md
perl -p -i -e 's,title:,#,s' *.md
perl -i -nle 'print if !/layout:/' *.md
perl -i -nle 'print if !/permalink:/' *.md
perl -i -nle 'print if !/navprev:/' *.md
perl -i -nle 'print if !/navnext:/' *.md
  # header hashmarks
sed -i 's/^#### /## /g' *.md
sed -i 's/^##### /### /g' *.md
sed -i 's/^###### /#### /g' *.md
  # miscellaneous
sed -i 's/ {at} /@/g' bio.md license.md
sed -i 's,](/about,](/bio,g' license.md prepare.md
  # superscript
sed -i 's,<sup>,^,g' *.md 
sed -i 's,</sup>,^,g' *.md
perl -p -i -e 's,(^|[^!])\[([^^!\]]+),\1\[____\2____,g' *.md
  #links
    # image
sed -i 's,](/img/plan/image/,](images/,g' *.md
sed -i 's,](/img/photo/,](images/,g' *.md
    # cross
      # /chapter#section to #section
perl -p -i -e 's,\]\(\/(notes|foreword|preface|introduction|hygiene|format|protocol|prepare|design|make|air|darkness|water|appendix-laws-of-life|appendix-pathology|faq|bibliography-and-influences|acknowledgments|services|license|bio)#,\]\(#,g' *.md
      # /chapter to #chapter
perl -p -i -e 's,\]\(\/(notes|foreword|preface|introduction|hygiene|format|protocol|prepare|design|make|air|darkness|water|appendix-laws-of-life|appendix-pathology|faq|bibliography-and-influences|acknowledgments|services|license|bio)\),\]\(#$1\),g' *.md
      # (/ to (http://darkroomretreat
perl -p -i -e 's,\(\/,\(http:\/\/darkroomretreat.com\/,g' *.md
  # anchors
    # generate
perl -p -i -e 's/^(#+ )([1-9] )?(appendix )?(- )?([A-Za-z0-9 _-]+)/\1\2\3\4\5 \{#\3\5\}/g' *.md
    # fix duplicates
# remove dashes in titles: perl -p -i -e 's,\{#([^\}-]+)- ,\{#$1,g' *.md
perl -pi -e '$a=1 if(!$a && s/{#constraints}/{#constraints-air}/);' air.md
perl -pi -e '$a=1 if(!$a && s/{#constraints}/{#constraints-1-air}/);' air.md
perl -pi -e 's/{#power}/{#power-air}/g' air.md
perl -pi -e '$a=1 if(!$a && s/{#constraints}/{#constraints-darkness}/);' darkness.md
perl -pi -e '$a=1 if(!$a && s/{#constraints}/{#constraints-1-darkness}/);' darkness.md
perl -pi -e 's/{#mechanics}/{#mechanics-faq}/g' faq.md
perl -pi -e 's/{#darkness}/{#darkness-hygiene}/g' hygiene.md
perl -pi -e 's/{#attitude}/{#attitude-hygiene}/g' hygiene.md
perl -pi -e 's/{#mechanics}/{#mechanics-hygiene}/g' hygiene.md
perl -pi -e 's/{#food}/{#food-hygiene}/g' hygiene.md
perl -pi -e 's/{#hygiene}/{#hygiene-introduction}/g' introduction.md
perl -pi -e 's/{#mechanics}/{#mechanics-protocol}/g' protocol.md
perl -pi -e 's/{#food}/{#food-protocol}/g' protocol.md
perl -pi -e 's/{#attitude}/{#attitude-protocol}/g' protocol.md
perl -pi -e 's/{#power}/{#power-protocol}/g' protocol.md
perl -pi -e '$a=1 if(!$a && s/{#basic}/{#basic-water}/);' water.md
perl -pi -e '$a=1 if(!$a && s/{#upgrade}/{#upgrade-water}/);' water.md
perl -pi -e '$a=1 if(!$a && s/{#basic}/{#basic-1-water}/);' water.md
perl -pi -e '$a=1 if(!$a && s/{#upgrade}/{#upgrade-1-water}/);' water.md
perl -pi -e '$a=1 if(!$a && s/{#basic}/{#basic-2-water}/);' water.md
perl -pi -e '$a=1 if(!$a && s/{#upgrade}/{#upgrade-2-water}/);' water.md
perl -p -i -e 's,\{#([^ \}]+) ,\{#$1-,g' *.md
perl -p -i -e 's,\{#([^ \}]+) ,\{#$1-,g' *.md
perl -p -i -e 's,\{#([^ \}]+) ,\{#$1-,g' *.md
perl -p -i -e 's,\{#([^ \}]+) ,\{#$1-,g' *.md
perl -p -i -e 's,\{#([^ \}]+) ,\{#$1-,g' *.md
perl -p -i -e 's,\{#([^ \}]+) ,\{#$1-,g' *.md
  # line breaks
  # end message
echo -book done

