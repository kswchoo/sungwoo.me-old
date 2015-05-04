all: clean scp
jekyll:
	jekyll build
scp: jekyll
	scp -r ./_site/* kswchoo@aws.sungwoo.me:/usr/share/nginx/html/
clean:
	rm -rf ./_site

