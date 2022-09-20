import os
import pymsteams


class Teams():
    ROBOT_LISTENER_API_VERSION = 2

    def end_suite(self, name, attributes):
        if "." in attributes['longname']:
            longname = attributes['longname'][attributes['longname'].index('.') + 1:]
        else:
            longname = attributes['longname']

        # getting two calls for each suit, ignoring for parent
        if longname == "Suites":
            return

        # teams_channel = os.environ['WEBHOOK_URL'].strip()
        teams_channel = "https://deloitte.webhook.office.com/webhookb2/a64d402f-8592-445b-9bbb-82c41515a31b@36da45f1-dd2c-4d1f-af13-5abe46b99921/JenkinsCI/abb8ebad71d5486ca40bf876d23ae09a/2280fbe7-60cf-4d35-b791-c2aa20d5a376"


        # return if channel is empty
        if not teams_channel:
            return

        build_url = os.environ['BUILD_URL']
        build_number = int(os.environ['BUILD_NUMBER'])

        doc = attributes['doc']
        status = attributes['status']
        message = attributes['message']
        elapsed_time = attributes['elapsedtime']
        statistics_string = attributes['statistics']
        statistics_array = statistics_string.split(" ")
        total_count = statistics_array[0]
        passed_count = statistics_array[3]
        failed_count = statistics_array[5]

        millis = int(elapsed_time)
        seconds = (millis / 1000) % 60
        seconds = int(seconds)
        minutes = (millis / (1000 * 60)) % 60
        minutes = int(minutes)
        hours = (millis / (1000 * 60 * 60)) % 24

        red_color = "#FF0000"
        green_color = "#00FF00"
        orange_color = "#FFA500"

        status_color = green_color
        status_icon = "https://www.freeiconspng.com/uploads/success-icon-10.png"
        status_text = 'Passed'

        if status == 'FAIL':
            if failed_count == total_count:
                status_color = red_color
                status_icon = "https://www.freeiconspng.com/uploads/ban-stop-icon-22.png"
                status_text = "Failed"
            else:
                status_color = orange_color
                status_icon = "https://www.freeiconspng.com/uploads/orange-warning-icon-3.png"
                status_text = "Partial Failures"

        teams_card = pymsteams.connectorcard(teams_channel)

        teams_card.title("Suit: " + longname)
        teams_card.text("Status: " + status_text)
        teams_card.color(status_color)

        teams_card_section = pymsteams.cardsection()

        teams_card_section.activityTitle(doc)
        teams_card_section.activitySubtitle("Elapsed time: %02d:%02d:%02d" % (hours, minutes, seconds))
        teams_card_section.activityImage(status_icon)
        teams_card_section.activityText(message)

        teams_card_section.addFact("Failed:", failed_count)
        teams_card_section.addFact("Passed:", passed_count)
        teams_card_section.addFact("Total:", total_count)
        teams_card_section.addFact("Report Link:", "http://localhost:63342/Jenkins_Project/Report/report.html")
        teams_card.addLinkButton("Build #" + str(build_number), build_url)
        teams_card.addSection(teams_card_section)

        teams_card.send()
