---
---


window.onload = load();

function load() {
  // if params detected, set active category
  let params = getQueryParameters();
  if ('category' in params) {
    setFilter(decodeURI(decodeURIComponent(params.category)));
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

// Initialize search functionality
document.addEventListener('DOMContentLoaded', function() {
  const searchInput = document.getElementById('dashboardSearch');
  if (searchInput) {
    searchInput.addEventListener('input', function() {
      applySearch(this.value);
    });
  }
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
  setQueryParameters(`category=${encodeURIComponent(category)}`);
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
  
  // Apply the current search filter with the new category
  const searchInput = document.getElementById('dashboardSearch');
  const searchTerm = searchInput ? searchInput.value : '';
  applySearch(searchTerm);
}

// Apply search filter to dashboard cards within selected category
// @param {string} searchTerm - The search term to filter by
function applySearch(searchTerm) {
  const searchLower = searchTerm.toLowerCase().trim();
  const categorySelect = document.getElementById('categorySelect');
  const selectedCategory = categorySelect.value.replaceAll(' ','');
  
  document.querySelectorAll('.col').forEach(card => {
    const nameElement = card.querySelector('a.fw-bold');
    const name = nameElement ? nameElement.textContent.toLowerCase().trim() : '';
    const descriptionElement = card.querySelector('.card-text p');
    const description = descriptionElement ? descriptionElement.textContent.toLowerCase().trim() : '';
    
    // Check if card matches search term
    const matchesSearch = searchLower === '' || 
                         name.includes(searchLower) || 
                         description.includes(searchLower);
    
    // Check if card matches category filter
    let matchesCategory = true;
    if (selectedCategory && selectedCategory !== 'all') {
      if (selectedCategory === 'recommended') {
        matchesCategory = card.classList.contains('recommended');
      } else if (selectedCategory === 'new') {
        matchesCategory = card.classList.contains('new');
      } else {
        matchesCategory = card.classList.contains(selectedCategory.replace(' ', ''));
      }
    }
    
    // Show card only if it matches both search and category
    if (matchesSearch && matchesCategory) {
      card.classList.remove('d-none');
    } else {
      card.classList.add('d-none');
    }
  });
  
  updateDashboardCount();
}

/**
 * Update the dashboard count display
 */
function updateDashboardCount() {
  const visibleCards = document.querySelectorAll('.col:not(.d-none)').length;
  const countElement = document.getElementById('dashboardCount');
  
  if (countElement) {
    countElement.textContent = `${visibleCards} Dashboards`;
  }
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


