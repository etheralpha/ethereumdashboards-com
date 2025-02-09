---
layout: default
---


{%- include partials/header.html -%}


{%- assign categories = '' -%}
{%- for dashboard in site.data.dashboards -%}
  {%- assign categories = categories | append: dashboard.categories | append: ',' -%}
{%- endfor -%}
{%- assign categories = categories | replace: ', ', ',' | split: ',' | uniq | sort -%}

<select id="categorySelect" class="form-select mx-auto mb-2 bg-blue" aria-label="select category" style="max-width: 18rem;">
  <option selected disabled value="all">Filter by category</option>
  <option value="all">All</option>
  {%- for category in categories -%}
    <option id="{{category | downcase | trim}}" value="{{category | downcase | trim}}">{{category}}</option>
  {%- endfor -%}
</select>

<div class="mx-auto mb-3 opacity-50">
  <small class="text-gray">{{site.data.dashboards | size}} Dashboards</small>
</div>


<!-- Content -->
<section class="pb-5">
  <div class="container">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 row-cols-xl-4 g-3 justify-content-center">
      {%- comment -%}
        <!-- 
        - name: L2 Beat
          link: https://l2beat.com/
          description: Analytics and research website about Ethereum layer 2 scaling, comparing major protocols live on Ethereum today.
          img: /assets/img/dashboards/l2beat.webp
          categories: Layer 2s
           -->
      {%- endcomment -%}
      {%- assign dashboards = site.data.dashboards | shuffle -%}
      {%- for dashboard in dashboards -%}
        {%- if dashboard.link -%}
          {%- assign img = "/assets/img/placeholder.png" -%}
          {%- if dashboard.img -%}
            {%- assign img = dashboard.img -%}
          {%- endif -%}
          {%- assign categories = dashboard.categories | split: ',' -%}
          <div class="col d-flex align-items-stretch all {{categories | join: '&&' | downcase | remove: ' ' | replace: '&&', ' '}}">
            <div class="card rounded-3 mx-auto bg-blue text-gray h-100 p-3">
              <a href="{{dashboard.link}}" target="_blank">
                <img src="{{img}}" loading="lazy" class="w-100 object-fit-cover rounded-2" 
                  style="aspect-ratio: 16 / 9; object-position: 0% 0%;">
              </a>
              <div class="card-body d-flex align-items-start flex-column p-0 pt-3">
                <div class="text-light fw-bold" style="opacity: 95%;">{{dashboard.name}}</div>
                <div class="card-text mb-auto">
                  {%- if dashboard.description -%}
                    <p>
                      {{dashboard.description}}
                    </p>
                  {%- endif -%}
                </div>
                <div>
                  {%- for category in categories -%}
                    <span class="badge rounded-pill me-1">{{category | strip}}</span>
                  {%- endfor -%}
                </div>
              </div>
            </div>
          </div>
        {%- endif -%}
      {%- endfor -%}
    </div>
  </div>
</section>

