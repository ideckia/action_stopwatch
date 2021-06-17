# Action for ideckia: Stopwatch

## Definition

Timer

## Properties

| Name | Type | Default | Description | Possible values |
| ----- |----- | ----- | ----- | ----- |
| precission | String | 's' | The timer will run at the interval of this value. | [m,s] |
| reset | Null<Bool> | false | If true it will reset the timer to 0. If false, it will continue from where it was paused. | null |


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