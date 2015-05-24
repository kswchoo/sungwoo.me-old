---
layout: post
title:  "코드 조각이 있는 포스트"
date:   2014-12-13
---

<p class="intro"><span class="dropcap">이</span> 포스트는 `_posts` 디렉터리 안에서 찾을 수 있습니다 - 이 포스트를 수정하고 다시 빌드 (혹은 `-w` 옵션을 주고 실행) 하시면 수정된 결과를 볼 수 있습니다. 새 포스트를 등록하시기 위해서는 `_posts` 디렉터리에 YYYY-MM-DD-포스트-이름.ext 의 형식으로 파일을 만드시면 됩니다.</p>

Jekyll은 강력한 코드 조각 지원 기능을 가지고 있습니다:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

[Jekyll 문서][jekyll] 를 참고하여 Jekyll의 더 많은 기능을 알아보세요. 새 기능 요청이나 버그 발견은 [Jekyll Github 리포지토리][jekyll-gh]로 보내 주세요.

[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
