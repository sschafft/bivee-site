---
layout: slider
class: slider
title: Systems Development
---

{% if site.categories.project %}
<div id="clients">
        <div class="projects">
          <h2>Highlighted Projects</h2>
          <hr>
{% for post in site.categories.project %}
          <div class="case">		
          	<a href="{{ post.url }}" title="{{ post.name }}, {{ post.job-title }}">
          	  <div class="picture">
          	    <img src="{{ post.photo-folder}}{{ post.image }}" />
          	  </div>
          	</a>	
          </div>
{% endfor %}
        </div>
</div>
{% endif %}
