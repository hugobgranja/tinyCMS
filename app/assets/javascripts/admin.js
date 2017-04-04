// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets

var menu = [];
var originalPages = {};
var originalLinks = {};

function set_menu() {
  menu = [];
  if($('#menu-input-1 span').html() != 'Assign menu items') {
    $('#menu-input-1').children().each(function() { 
      menu.push($(this)[0].outerHTML);
    });
  }
}

function update_menu() {
  $('#menu-input-1').html(menu.join(', '));
}

function dropdown_click(e) {
  var menuEntry = $(this).find('#menu-entry')[0].outerHTML;

  var index = menu.indexOf(menuEntry);

  if (index > -1) {
    menu.splice(index, 1);
    $(this).find('.fa').addClass('hidden');
  }
  else {
    menu.push(menuEntry);
    $(this).find('.fa').removeClass('hidden');
  }

  update_menu();

  e.preventDefault();
}

function submit_menu() {
  var mI2C = [];

  $.each(menu, function(i, v) {
    var html = $(v)[0];
    var id = html.getAttribute('data-id');
    var type = html.getAttribute('data-type');

    mI2C.push(type + " " + id);
  });

  $('#menu-input-2').val(mI2C.join(", "));
  $('#menu-update').submit();
}


// ===============================================================
//
// On document ready
//
// ===============================================================

$(document).on('turbolinks:load', function() {

  // Focus on first input
  $('#new-page-').on('shown.bs.modal', function () {
    $(this).find('#page_name').focus();
  });

  $('#new-link-').on('shown.bs.modal', function () {
    $(this).find('#link_name').focus();
  });

  // Tinymce fix focus
  $(document).on('focusin', function(e) {
    if ($(event.target).closest(".mce-window").length) {
      e.stopImmediatePropagation();
    }
  });

  // Initial menu values
  set_menu();

  // Menu dropdown option click
  $('#menu-options a').click(dropdown_click);

  // Stop menu dropdown from hiding after clicking option
  $('#menu-options').click(function(e) {
    e.stopPropagation();
  });

  // Menu submission
  $('#menu-submit').click(submit_menu);

  // Cancel modal changes
  $('#new-page- #close').click(function(e) {
    var content = tinymce.get('new-page-content-').getContent();

    if(content != '') {
      var r = confirm('You have unsaved changes, are you sure you want to discard them?');
    
      if(r) {
        $('#new-page- #page_name').val('');
        tinymce.get('new-page-content-').setContent('');
      }
      else {
        e.stopPropagation();
      }
    }    
  });

  $('#new-link- #close').click(function() {
    $('#new-link- #link_name').val('');
    $('#new-link- #link_url').val('');
  });

  $('div[id^=edit-page-]').on('show.bs.modal', function () {
    var id = this.id.slice(10, this.id.length);
    var name = $(this).find('#page_name').val();
    var content = tinymce.get('edit-page-content-' + id).getContent();
    originalPages[id] = { name: name, content: content };
  });

  $('div[id^=edit-page-] #close').click(function(e) {
    var $modal = $(this).closest('div[id^=edit-page-]');
    var modal_id = $modal.attr('id');
    var id = modal_id.slice(10, modal_id.length);
    var $name = $modal.find('#page_name');
    var content = tinymce.get('edit-page-content-' + id).getContent();

    if(originalPages[id]['name'] != $name.val() || originalPages[id]['content'] != content) {
      var r = confirm('You have unsaved changes, are you sure you want to discard them?');    

      if(r) {
        $name.val(originalPages[id]['name']);
        tinymce.get('edit-page-content-' + id).setContent(originalPages[id]['content']);
        delete originalPages[id];
      }
      else {
        e.stopPropagation();
      }
    }
  });

  $('div[id^=edit-link-]').on('show.bs.modal', function () {
    var id = this.id.slice(10, this.id.length);
    var name = $(this).find('#link_name').val();
    var url = $(this).find('#link_url').val();
    originalLinks[id] = { name: name, url: url };
  });

  $('div[id^=edit-link-] #close').click(function(e) {
    var $modal = $(this).closest('div[id^=edit-link-]');
    var modal_id = $modal.attr('id');
    var id = modal_id.slice(10, modal_id.length);
    var $name = $modal.find('#link_name');
    var $url = $modal.find('#link_url');

    if(originalLinks[id]['name'] != $name.val() || originalLinks[id]['url'] != $url.val()) {
      var r = confirm('You have unsaved changes, are you sure you want to discard them?');

      if(r) {
        $name.val(originalLinks[id]['name']);
        $url.val(originalLinks[id]['url']);
        delete originalLinks[id];
      }
      else {
        e.stopPropagation();
      }
    }
  });
  
});