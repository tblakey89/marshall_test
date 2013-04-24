app = angular.module("Exam", ["ngResource"])

@ExamCtrl = ($scope, $resource) ->
  Entry = $resource("/sections/1.json", {id: "@id"}, {update: {method: "PUT"}})
  Entry2 = $resource("/sections/2.json", {id: "@id"}, {update: {method: "PUT"}})
  Entry3 = $resource("/sections/3.json", {id: "@id"}, {update: {method: "PUT"}})
  Entry4 = $resource("/sections/4.json", {id: "@id"}, {update: {method: "PUT"}})
  Entry5 = $resource("/sections/5.json", {id: "@id"}, {update: {method: "PUT"}})
  $scope.sections = Entry.query()

  $scope.current = 1
  $scope.answer = []
  $scope.correct = []
  $scope.section  = []
  $scope.begin = 0
  $scope.name = ''
  $scope.video = ''
  document.getElementById('iframeID').src = "http://player.vimeo.com/video/64311295"

  $scope.testClass = (theName, theVideo) ->
    $scope.video_id = theVideo
    $scope.name = theName
    document.getElementById('iframeID').src = "http://player.vimeo.com/video/" + theVideo
    return 'test'

  $scope.beginSection = ($event) ->
    $scope.begin = $scope.begin + 1
    $scope.video = true
    $event.preventDefault()

  $scope.showQuestion = (id) ->
    if id == $scope.begin
      return true
    else
      return false

  $scope.goToQuestion = (id) ->
    if $scope.video
      $scope.begin = id

  $scope.answerQuestion = (id, answer) ->
    $scope.answer[id] = answer

  $scope.answered = (id, answer) ->
    if $scope.answer[id] == answer
      return 'answer_status_answered'
    else
      return ''

  $scope.videoWatched = (id) ->
    if $scope.video
      return 'complete'
    else
      return 'incomplete'

  $scope.answeredQuestion = (id) ->
    if $scope.answer[id] != undefined
      return 'complete'
    else
      return 'incomplete'

  $scope.sectionComplete = (id) ->
    if $scope.answer.length == 7
      return 'complete'
    else
      return 'incomplete'

  $scope.sectionCompleteBool = (id) ->
    return $scope.answer.length == 7

  $scope.answerCorrect = (id, correct) ->
    if $scope.answer[id] == correct
      $scope.correct[id] = true
      return 'correct'
    else
      $scope.incorrect = $scope.incorrect + 1
      $scope.correct[id] = false
      return 'incorrect'

  $scope.finishSection = (id) ->
    if $scope.answer.length == 7
      $scope.begin = 7

  $scope.sectionOutcome = (id) ->
    pass = 0
    if $scope.sectionCompleteBool(0)
      for correct in $scope.correct
        if correct
          pass = pass + 1
      if pass > 4
        return true
      else
        return false

  $scope.sectionStatus = (id) ->
    if $scope.section[id]
      return 'complete'
    else
      return 'incomplete'

  $scope.repeatSection = ($event) ->
    $scope.answer = []
    $scope.correct = []
    $scope.video = false
    $scope.begin = 0
    $event.preventDefault()

  $scope.nextSection = ($event) ->
    $scope.answer = []
    $scope.correct = []
    $scope.video = false
    $event.preventDefault()
    $scope.section[$scope.current] = true
    $scope.current = $scope.current + 1
    $scope.begin = 0
    switch $scope.current
      when 2 then $scope.sections = Entry2.query()
      when 3 then $scope.sections = Entry3.query()
      when 4 then $scope.sections = Entry4.query()
      when 5 then $scope.sections = Entry5.query()
      when 6 then $scope.begin = 8

  $scope.endOfTest = (id) ->
    if $scope.begin == 8
      $scope.sections = ''
      $scope.name = 'Complete'
      return true

  $scope.footerClass = (id) ->
    if $scope.begin == 8
      return 'container_footer'
    else
      return 'footer_sections'

  $scope.showCtrl = (id) ->
    return true
