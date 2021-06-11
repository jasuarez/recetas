---
permalink: /assets/js/search.js
---

(function() {
  function displaySearchResults(results, store) {
    var searchResults = document.getElementById('search-results');
    var sortResults = [];

    //results.sort((a, b) => (a.menu > b.menu) ? 1 : -1);
    if (results.length) { // Are there any results?
      for (var i = 0; i < results.length; i++) {
        sortResults.push(store[results[i].ref]);
      }
      sortResults.sort((a, b) => a.title > b.title ? 1 : -1);
      {% for menu in site.data.menu %}
        var appendString = '';
        for (var i = 0; i < sortResults.length; i++) {  // Iterate over the results
          var item = sortResults[i];
	  if (item.menu == "{{ menu }}")
            appendString += '<li><a href="' + item.url + '">' + item.title + '</a>';
        }
        searchResults.innerHTML += appendString.length > 0 ? '<h2>{{ menu }}s</h2>' + appendString : '';
      {% endfor %}
    } else {
      searchResults.innerHTML = '<li>No se ha encontrado nada</li>';
    }
  }

  function getQueryVariable(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split('&');

    for (var i = 0; i < vars.length; i++) {
      var pair = vars[i].split('=');

      if (pair[0] === variable) {
        return decodeURIComponent(pair[1].replace(/\+/g, '%20'));
      }
    }
  }

  var searchTerm = getQueryVariable('query');


  if (searchTerm) {
    document.getElementById('search-box').setAttribute("value", searchTerm);

    // Initalize lunr with the fields it will be searching on. I've given title
    // a boost of 10 to indicate matches on this field are more important.
    var idx = lunr(function () {
      this.field('id');
      this.field('title', { boost: 10 });
      this.field('menu');
      this.field('ingredientes');

      // Add data to lunr
      for (var key in window.store) {
        this.add({
          'id': key,
          'title': window.store[key].title,
          'menu': window.store[key].menu,
          'ingredientes': window.store[key].ingredientes,
        });
      }
    });

    var results = idx.search(searchTerm); // Get lunr to perform a search
    displaySearchResults(results, window.store); // We'll write this in the next section
  }
})();

