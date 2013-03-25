# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.widget "custom.catcomplete", $.ui.autocomplete,
         _renderMenu: (ul, items) ->
           that = this
           currentCategory = ""
           $.each items, (index, item) ->
             unless item.category is currentCategory
               ul.append "<li class='ui-autocomplete-category'>" + item.category + "</li>"
               currentCategory = item.category
             that._renderItemData ul, item