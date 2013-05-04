#= require mercury/views/modal
#= require mercury/templates/panel

class Mercury.Panel extends Mercury.Modal

  @logPrefix: 'Mercury.Panel:'
  @className: 'mercury-dialog mercury-panel'

  @elements:
    content: '.mercury-panel-content'
    contentContainer: '.mercury-panel-content-container'
    titleContainer: '.mercury-panel-title'
    title: '.mercury-panel-title span'

  @events:
    'mercury:interface:hide': 'hide'
    'mercury:interface:resize': 'resize'
    'mercury:panels:hide': 'hide'
    'mousedown .mercury-panel-title em': 'prevent'
    'click .mercury-panel-title em': 'hide'

  primaryTemplate: 'panel'
  releaseOnHide: false

  setWidth: (width) ->
    @css(width: width)


  resize: (animate = true, dimensions = null) =>
    clearTimeout(@showContentTimeout)
    if typeof(animate) == 'object'
      dimensions = animate
      animate = false
    dimensions ||= Mercury.interface?.dimensions?()
    @css(top: dimensions.top + 10, bottom: dimensions.bottom + 10) if dimensions
    @addClass('mercury-no-animation') unless animate
    titleHeight = @$titleContainer.outerHeight()
    height = @$el.height()
    @$contentContainer.css(height: height - titleHeight)
    if animate
      @showContentTimeout = @delay(300, @showContent)
    else
      @showContent(false)
    @removeClass('mercury-no-animation')


  onShow: ->
    Mercury.trigger('panels:hide')


  onHide: ->
    Mercury.trigger('focus')
