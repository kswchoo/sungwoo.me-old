all: clean scp
jekyll:
	jekyll build
scp: jekyll
	scp -r ./_site/* kswchoo@sungwoo.me:~/html/
clean:
	rm -rf ./_site

