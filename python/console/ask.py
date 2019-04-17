def ask(question, answers, default_answer, type_validator=str):
    # Get number of answers
    if not isinstance(answers, list):
        answers = [answers]
    if answers[0] == '':
        n_answers = 0
    else:
        n_answers = len(answers)

    # Append answer hints to question
    if n_answers > 0 or str(default_answer) != '':
        question_to_show = question + ' ('
        if str(default_answer) != '':
            question_to_show += '[%s]' % str(default_answer)
            if n_answers > 0:
                question_to_show += '/'
        if n_answers > 0:
            question_to_show += '%s' % '/'.join([i for i in answers if str(i) != str(default_answer)])
        question_to_show += ')'

    else:
        question_to_show = question

    # Ask user for an answer
    while True:
        user_answer = input(question_to_show)
        # Set default option when user presses Enter
        if user_answer == '':
            if str(default_answer) == '':
                print('Please try again')
            else:
                user_answer = default_answer
        # Validate user answer
        try:
            user_answer = type_validator(user_answer)
        except ValueError:
            print('Answer type not allowed. Reply something that can be converted to \'%s\'' % repr(type_validator))
            continue

        # Stop if got an answer that is allowed, or if there are no good answers
        if user_answer in answers or n_answers == 0:
            break
        else:
            print('Please try again')

    return user_answer
