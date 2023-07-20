config=$(cat octopull.config.json | jq)
key=$(echo $config | jq -r .key)
mpan=$(echo $config | jq -r .mpan)
serial=$(echo $config | jq -r .serial)

format=$1
from_date=$2

now=$(date +"%Y-%m-%d")
last_pulled=$(date -r octopull.data.json "+%Y-%m-%d")

echo "Checking data expiration..."
if [[ "$now" -gt "$last_pulled" ]]; then
    echo "Requesting new consumption data..."
    curl -u "${key}" "https://api.octopus.energy/v1/electricity-meter-points/${mpan}/meters/${serial}/consumption/?period_from=${fromDate}&page_size=25000" | jq > octopull.data.json
    echo "Processing latest data..."
else 
    echo "Processing existing data..."
fi

if [[ "$format" == "csv"  ]] || [[ "$format" == "sql" ]]; then
    echo "Converting data to CSV format..."
    rm octopull.data.csv
    jq -r '["usage", "start_date", "start_time", "end_date", "end_time"], (.results[] | [.consumption, "\(.interval_start | split("T")[0])", "\(.interval_start | split("T")[1])", "\(.interval_end | split("T")[0])", "\(.interval_end | split("T")[1])"] | map(if type == "string" then gsub("T"; " ") | gsub("Z"; "") else . end)) | @csv' octopull.data.json > octopull.data.csv
fi

if [[ "$format" == "sql" ]]; then
    echo "Converting data to SQL format..."
    awk '{print "(", $0, "),"}' octopull.data.csv > octopull.data.txt
    rm octopull.data.csv
fi

echo "\nComplete!"