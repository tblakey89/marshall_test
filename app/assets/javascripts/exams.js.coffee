app = angular.module("Exam", ["ngResource"])

@ExamCtrl = ($scope, $resource, $http) ->
  Entry = $resource("/sections/1.json", {id: "@id"}, {update: {method: "PUT"}})
  Entry2 = $resource("/sections/2.json", {id: "@id"}, {update: {method: "PUT"}})
  Entry3 = $resource("/sections/3.json", {id: "@id"}, {update: {method: "PUT"}})
  Entry4 = $resource("/sections/4.json", {id: "@id"}, {update: {method: "PUT"}})
  Entry5 = $resource("/sections/5.json", {id: "@id"}, {update: {method: "PUT"}})
  $scope.sections = Entry.query()
#need reload video button
  $scope.current = 1
  $scope.answer = []
  $scope.correct = []
  $scope.section  = []
  $scope.begin = 0
  $scope.name = ''
  $scope.video = ''
  $scope.method = "POST"

  document.getElementById('iframeID').src = "http://player.vimeo.com/video/64311295"

  $scope.setUser = (id) ->
    $scope.user = id

  #sets the video to the first video_id, sets the name, and returns the css class
  $scope.testClass = (theName, theVideo) ->
    $scope.video_id = theVideo
    $scope.name = theName
    document.getElementById('iframeID').src = "http://player.vimeo.com/video/" + theVideo
    return 'test'

  #begins the section and sets video to watched
  $scope.beginSection = ($event) ->
    $scope.begin = $scope.begin + 1
    $scope.video = true
    $event.preventDefault()

  #finishes the section
  $scope.finishSection = ($event) ->
    if $scope.sectionCompleteBool(0)
      $scope.begin = 7
    $event.preventDefault()

  #moves it onto the next section
  $scope.next = ($event) ->
    if $scope.begin isnt 6
      $scope.begin = $scope.begin + 1
    $event.preventDefault()

  #shows the current question
  $scope.showQuestion = (id) ->
    if id == $scope.begin
      return true
    else
      return false

  #go to selected question
  $scope.goToQuestion = (id) ->
    if $scope.video and  $scope.begin isnt  7
      $scope.begin = id

  #answers the current question
  $scope.answerQuestion = (id, answer) ->
    $scope.answer[id] = answer

  #checks to see of question is answered
  $scope.answered = (id, answer) ->
    if $scope.answer[id] == answer
      return 'answer_status_answered'
    else
      return ''

  #checks if video is watched
  $scope.videoWatched = (id) ->
    if $scope.video
      return 'complete'
    else
      return 'incomplete'

  #checks if question is answered, returns class
  $scope.answeredQuestion = (id) ->
    if $scope.answer[id] != undefined
      return 'complete'
    else
      return 'incomplete'

  #returns a class depending on section complete boolean
  $scope.sectionComplete = (id) ->
    if $scope.sectionCompleteBool(0)
      return 'complete'
    else
      return 'incomplete'

  #returns true or false based on whether the section is complete
  $scope.sectionCompleteBool = (id) ->
    answered = 0
    for answer in $scope.answer
      if answer isnt undefined
        answered = answered + 1
    return answered == 6

  #checks to see if answer is correct, returns string
  $scope.answerCorrect = (id, correct) ->
    if $scope.answer[id] == correct
      $scope.correct[id] = true
      return 'correct'
    else
      $scope.incorrect = $scope.incorrect + 1
      $scope.correct[id] = false
      return 'incorrect'

  #returns the outcome of the section, pass of fail
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

  #returns status of section
  $scope.sectionStatus = (id) ->
    if $scope.section[id]
      return 'complete'
    else
      return 'incomplete'

  #restarts the section and sends answers to server
  $scope.repeatSection = ($event) ->
    for key, value of $scope.answer
      $scope.add(key, value, $scope.user)
    $scope.answer = []
    $scope.correct = []
    $scope.video = false
    $scope.begin = 0
    $event.preventDefault()

  #goes to next section and sends answers to server
  $scope.nextSection = ($event) ->
    for key, value of $scope.answer
      $scope.add(key, value, $scope.user)
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

  #ends the test
  $scope.endOfTest = (id) ->
    if $scope.begin == 8
      $scope.sections = ''
      $scope.name = 'Complete'
      return true

  #shows the footer class based on the situation
  $scope.footerClass = (id) ->
    if $scope.begin == 8
      return 'container_footer'
    else
      return 'footer_sections'

  #used in ng-hide and shows
  $scope.showCtrl = (id) ->
    return true

  #adds the answers to the database
  $scope.add = (question, answer, user) ->
    FormData =
      question_id: question
      answer: answer
      user_id: user*$scope.current
    $http(
      method: $scope.method
      url: "../user_answers"
      data: FormData
      #headers:
        #  "Content-Type": "application/x-www-form-urlencoded"
      #cache: $templateCache
    ).success((response) ->
      $scope.codeStatus = response.data
    ).error (response) ->
      $scope.codeStatus = response or "Request failed"
