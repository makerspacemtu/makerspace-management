'use strict';

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

$(function () {
  var modal_holder_selector = '#modal-holder';
  var modal_selector = '.modal';

  $(document).on('click', 'a[data-modal]', function () {
    var location = $(this).attr('href');
    // Load modal dialog from server
    $.get(location, function (data) {
      $(modal_holder_selector).html(data).find(modal_selector).modal();
    });
    return false;
  });

  $(document).on('ajax:success', 'form[data-modal]', function (event) {
    var _event$detail = _slicedToArray(event.detail, 3),
        data = _event$detail[0],
        _status = _event$detail[1],
        xhr = _event$detail[2];

    var url = xhr.getResponseHeader('Location');
    if (url) {
      // Redirect to url
      window.location = url;
    } else {
      // Remove old modal backdrop
      $('.modal-backdrop').remove();
      // Update modal content
      var modal = $(data).find('body').html();
      $(modal_holder_selector).html(modal).find(modal_selector).modal();
    }

    return false;
  });
});
