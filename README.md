# Action for [ideckia](https://ideckia.github.io/): Stopwatch

## Description

Simple timer

## Properties

| Name | Type | Default | Description | Possible values |
| ----- |----- | ----- | ----- | ----- |
| precission | String | 's' | The timer will run at the interval of this value. | [m,s] |

## On single click

Starts or pauses the timer

## On long press

Resets timer to 0

## Example in layout file

```json
{
    "state": {
        "text": "action_stopwatch project",
        "bgColor": "00ff00",
        "action": {
            "name": "stopwatch",
            "props": {
                "precission": "s"
            }
        }
    }
}
```