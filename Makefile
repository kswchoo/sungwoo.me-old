all: clean scp
jekyll:
	jekyll build
compass:
	compass compile
scp: jekyll compass
	scp -r ./_site/* kswchoo@aws.sungwoo.me:/usr/share/nginx/html/
clean:
	rm -rf ./_site

