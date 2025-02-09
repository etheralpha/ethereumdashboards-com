---
---


window.onload = load();

function load() {
  // if params detected, set active category
  let params = getQueryParameters();
  if ('category' in params) {
    setFilter(decodeURI(params.category));
  }
  updateLinkTargets();
}

// add an event listener to categories
document.querySelectorAll('.badge').forEach(badge => {
  badge.addEventListener('click', (event) => {
    let category = badge.innerText.toLowerCase();
    setFilter(category);
  });
});
// add an event listener to dropdown
document.getElementById('categorySelect').addEventListener('change', function() {
  setFilter(this.value);
});



// update the url parameters (does not trigger page refresh)
function setQueryParameters(params=false) {
  // pass params as string; "x=i&y=j&z=k"
  params = params ? params : '';
  if (params != '') {
    params = '?' + params;
  }
  // let url = `${window.location.hostname}/${params}`;
  // url = url.replace('localhost', '127.0.0.1');
  window.history.replaceState(null, '', params);
}
// gets the url parameters
function getQueryParameters() {
  try {
    let queryString = location.search.slice(1), params = {};
    queryString.replace(/([^=]*)=([^&]*)&*/g, (_, key, value) => {
      params[key] = value;
    });
    return params;
  } catch {
    return null;
  }
}
function setFilter(category) {
  // set category dropdown to active filter
  console.log('setFilter...', category)
  // document.getElementById(category).checked = true;
  document.getElementById('categorySelect').value = category;
  console.log('select updated')
  // set url parameters
  setQueryParameters(`category=${category}`);
  console.log('url updated')
  // update page to apply filter
  applyFilter(category);

  // try {
  // }
  // catch {
  //   console.log(`filter category does not exist: ${category}`);
  // }
}
function applyFilter(category) {
  console.log('applying filter...', category)
  document.querySelectorAll('.col').forEach(card => {
    card.classList.add('d-none');
  });
  document.querySelectorAll(`.${category.replace(' ','')}`).forEach(card => {
    card.classList.remove('d-none');
  });
}





// open external links and pdfs in new tab
function updateLinkTargets() {
  {%- assign site_url = site.url | split: '//' | last -%}
  document.querySelectorAll('a').forEach(link => {
    let href = link.href;
    // set all links to open in new tab
    if (/^(https?:)?\/\//.test(link.href)) {
      link.target = '_blank';
    }
    // if current domain, use same tab
    if (href != undefined && href.includes('{{site_url}}')) {
      link.target = '_self';
    }
    // if relative links, use new tab
    if (href != undefined && !href.includes('https')) {
      link.target = '_self';
    }
    // open all .pdf, .png, .jpg, .mp4 in new tab
    if (/(\.pdf$|\.png$|\.jpe*g$|\.mp4)/.test(href)) {
      link.target = '_blank';
    }
    // if new-tab class, use new tab
    if (link.classList.contains('new-tab')) {
      link.target = '_blank';
    }
  })
}


