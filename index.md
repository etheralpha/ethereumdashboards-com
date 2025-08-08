---
layout: default
---


{%- comment -%}
  {{". \_scripts/bin/activate && python \_scripts/convert_images.py" | shell}}
{%- endcomment -%}

{%- include partials/header.html -%}


{%- assign newly_added = "" -%}
{%- assign newly_added_limit = 10 -%}
{%- for dashboard in site.data.dashboards limit:newly_added_limit -%}
  {%- assign newly_added = newly_added | append: dashboard.link | append: ", " -%}
{%- endfor -%}



{%- assign categories = '' -%}
{%- for dashboard in site.data.dashboards -%}
  {%- assign categories = categories | append: dashboard.categories | append: ',' -%}
{%- endfor -%}
{%- assign categories = categories | replace: ', ', ',' | split: ',' | uniq | sort -%}


{%- assign category_counts = '' -%}
{%- for category in categories -%}
  {%- assign count = 0 -%}
  {%- for dashboard in site.data.dashboards -%}
    {%- if dashboard.categories contains category -%}
      {%- assign count = count | plus: 1 -%}
    {%- endif -%}
  {%- endfor -%}
  {%- assign category_count = category | append: " ("  | append: count  | append: ")" -%}
  {%- assign category_counts = category_counts | append: category_count | append: ',' -%}
{%- endfor -%}
{%- assign category_counts = category_counts | split: ',' -%}


{%- assign categories = category_counts -%}

<!-- Filter Section -->
<div class="mb-4 mx-auto d-flex flex-column flex-md-row align-items-center gap-3" style="max-width: 90%;">
  <select id="categorySelect" class="form-select mx-auto bg-blue" aria-label="select category" style="max-width: 18rem; height: 3.5rem;">
    <option selected disabled value="all">Filter by category</option>
    <option value="all">All</option>
    <option value="recommended">Recommended</option>
    <option value="new">Newly Added</option>
    {%- for category in categories -%}
      {%- assign category_id = category | split: " (" | first | downcase | trim -%}
      <option id="{{category_id}}" value="{{category_id}}">{{category}}</option>
    {%- endfor -%}
  </select>
  
  <input
    type="text"
    id="dashboardSearch"
    class="form-control"
    placeholder="Search by name"
    aria-label="Search dashboards"
    style="font-size: 1.1rem; padding: 1rem 1.25rem; height: 3.5rem; max-width: 32rem;"
  >
</div>

<div class="mx-auto mb-3 opacity-50">
  <small class="text-gray" id="dashboardCount">{{site.data.dashboards | size}} Dashboards</small>
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
          {%- assign new = "" -%}
          {%- if newly_added contains dashboard.link -%}
            {%- assign new = "new" -%}
          {%- endif -%}
          {%- assign recommended = "" -%}
          {%- if dashboard.recommended -%}
            {%- assign recommended = "recommended" -%}
          {%- endif -%}
          {%- assign categories = dashboard.categories | split: ',' | sort -%}
          <div class="col d-flex align-items-stretch all {{new}} {{recommended}}
            {{categories | join: '&&' | downcase | remove: ' ' | replace: '&&', ' '}}">
            <div class="card rounded-3 mx-auto bg-blue text-gray h-100 p-3">
              {%- if dashboard.recommended -%}
                <div class="badge badge-recommended rounded-pill mx-auto">Recommended</div>
              {%- elsif newly_added contains dashboard.link -%}
                <div class="badge badge-new rounded-pill mx-auto">Newly Added</div>
              {%- endif -%}
              <a href="{{dashboard.link}}" target="_blank">
                <img src="{{img}}" loading="lazy" class="w-100 object-fit-cover rounded-2" 
                  style="aspect-ratio: 16 / 9; object-position: 0% 0%;">
              </a>
              <div class="card-body d-flex align-items-start flex-column p-0 pt-3">
                <!-- <div class="text-light fw-bold" style="opacity: 95%;"> -->
                  <a href="{{dashboard.link}}" target="_blank" class="text-light fw-bold" style="opacity: 95%;">
                    {{dashboard.name}}
                  </a>
                <!-- </div> -->
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

