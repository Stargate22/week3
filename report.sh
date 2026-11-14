#!/usr/bin/env bash

# Week 3 - Server Status Report

# Date and time
DATE=$(TZ=Europe/Helsinki date '+%Y-%m-%d %H:%M:%S %Z %z')

# Server uptime
UPTIME=$(uptime -p)

# Disk usage
DISK=$(df -P / | awk 'NR==2 {print $5}')
DISK_NUMBER=${DISK%\%}

# RAM information
RAM_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
RAM_AVAILABLE=$(free -m | awk '/^Mem:/ {print $7}')

# Check disk space status
check_disk() {
    if [ "$DISK_NUMBER" -ge 80 ]; then
        STATUS="WARNING"
    else
        STATUS="OK"
    fi
}

check_disk

# Show results
echo "Server Status Report"
echo "--------------------"
echo "Date: $DATE"
echo "Uptime: $UPTIME"
echo "Disk usage: $DISK"
echo "Disk status: $STATUS"
echo "Total RAM: $RAM_TOTAL MiB"
echo "Available RAM: $RAM_AVAILABLE MiB"

# Create the HTML report

cat > /var/www/html/viikko3/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Week 3 - Server Status Report</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f8ff;
            color: #243b64;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: auto;
        }

        header {
            background: #dbeafe;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
        }

        h1 {
            margin-bottom: 10px;
        }

        nav {
            margin: 25px 0;
            text-align: center;
        }

        nav a {
            display: inline-block;
            background: #dbeafe;
            color: #243b64;
            padding: 12px 20px;
            margin: 5px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
        }

        nav a:hover {
            background: #93c5fd;
        }

        nav .active {
            background: #243b64;
            color: white;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 15px;
            margin-top: 25px;
        }

        .card {
            padding: 25px;
            border-radius: 15px;
        }

        .blue {
            background: #dbeafe;
        }

        .green {
            background: #d9f7e8;
        }

        .yellow {
            background: #fff0ba;
        }

        .purple {
            background: #f5ddfa;
        }

        .pink {
            background: #ffe0e9;
        }

        .card h2 {
            font-size: 17px;
            margin-top: 0;
        }

        .value {
            font-size: 24px;
            font-weight: bold;
            overflow-wrap: anywhere;
        }

        section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-top: 25px;
        }

        li {
            margin-bottom: 12px;
        }

        code {
            background: none;
            padding: 0;
            border-radius: 0;
            overflow-wrap: anywhere;
        }

        footer {
            text-align: center;
            margin: 30px;
        }
	.github-button {
    	    display: inline-block;
    	    background: #c7d2fe;
    	    color: #243b64;
    	    padding: 14px 25px;
    	    border-radius: 12px;
    	    text-decoration: none;
    	    font-weight: bold;
    	    border: 2px solid #a5b4fc;
    	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	}

	.github-button:hover {
    	    background: #a5b4fc;
    	    transform: translateY(-2px);
	}
    </style>
</head>

<body>
<div class="container">

    <header>
        <h1>Server Status Report</h1>
        <p>Linux Course - Week 3</p>
    </header>

    <nav>
        <a href="/">Week 1</a>
        <a href="/viikko2/">Week 2</a>
        <a href="/viikko3/" class="active">Week 3</a>
    </nav>

    <section>
        <h2>Current Server Status</h2>

        <div class="grid">

            <div class="card blue">
                <h2>Report Generated</h2>
                <div class="value">$DATE</div>
            </div>

            <div class="card purple">
                <h2>Server Uptime</h2>
                <div class="value">$UPTIME</div>
            </div>

            <div class="card yellow">
                <h2>Disk Usage</h2>
                <div class="value">$DISK</div>
            </div>

            <div class="card green">
                <h2>Disk Status</h2>
                <div class="value">$STATUS</div>
            </div>

            <div class="card blue">
                <h2>Total RAM</h2>
                <div class="value">$RAM_TOTAL MiB</div>
            </div>

            <div class="card pink">
                <h2>Available RAM</h2>
                <div class="value">$RAM_AVAILABLE MiB</div>
            </div>

        </div>

        <p>Disk status is OK below 80% and WARNING at 80% or above.</p>
    </section>

    <section>
        <h2>Linux Commands I Used</h2>

        <ul>
            <li><code>date</code> - Shows the current date and time.</li>
            <li><code>uptime -p</code> - Shows how long the server has been running.</li>
            <li><code>df -P /</code> - Shows disk usage.</li>
            <li><code>free -m</code> - Shows RAM information in MiB.</li>
        </ul>

        <p>
            I also used piping with awk to get the
            disk usage percentage from the df command.
        </p>
    </section>

    <section>
        <h2>How My Bash Script Works</h2>

        <p>
            My Bash script uses Linux commands to collect
            information about the server.
        </p>

        <p>
            The results are saved in variables and added
            to this HTML page.
        </p>

        <p>
            I used a function and an if statement to check
            the disk usage. If the usage is 80% or higher,
            the status changes to WARNING.
        </p>
    </section>

    <section>
    <h2>Automatic Updates</h2>

    <p>
        I used cron to update my server status report
        automatically every minute.
    </p>

    <p>
        Cron runs my Bash script once per minute.
        I checked the report generation time and
        confirmed that it changes automatically.
    </p>

    <p>
        The cron service is enabled to start
        automatically after a server reboot.
    </p>
</section>

    <section>
    <h2>Testing</h2>

    <h3>Bash Script Test</h3>
    <p>
        I checked the script with bash -n report.sh.
        The syntax check passed, and the script
        worked when I ran it manually.
    </p>

    <h3>Disk Status Tests</h3>
    <p>
        I tested the disk status function with
        three different values.
    </p>

    <ul>
        <li>50% - OK (Passed)</li>
        <li>80% - WARNING (Passed)</li>
        <li>90% - WARNING (Passed)</li>
    </ul>

    <p>
        All three tests passed.
        The actual disk usage was 4%, and
        the status was correctly shown as OK.
    </p>

    <h3>Automatic Updates</h3>
    <p>
        I tested the cron schedule by refreshing
        the website after approximately 1-2 minutes.
        The report generation time had changed,
        so the automatic update worked.
    </p>

    <h3>Server Reboot Test</h3>
<p>
    I restarted my Ubuntu server using sudo reboot.
    After the restart, I checked that the Week 1,
    Week 2 and Week 3 websites were working.
</p>

<p>
    Nginx and cron started automatically after
    the reboot. I also checked the Week 2 visitor
    counter and confirmed that it still worked.
</p>

<p>
    I waited approximately 2 minutes and refreshed
    the Week 3 page. The report generation time
    had changed, so the automatic updates were
    still working after the reboot.
</p>

</section>

    <section>
        <h2>What I Learned</h2>

        <p>
         I learned how to use Bash commands and
	 variables to collect information about 
	 my server. I also learned how to use 
	 cron to update my website automatically
	 every minute.
        </p>
    </section>

    <footer>
    <p>Linux Course - Week 3</p>
    <p>
        <a class="github-button"
           href="https://github.com/Stargate22/week3"
           target="_blank" rel="noopener noreferrer">
            View Project on GitHub ↗
        </a>
    </p>
</footer>

</div> 
</body>
</html>
EOF
