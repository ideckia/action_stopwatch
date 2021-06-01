# Action for ideckia: Stopwatch

## Definition

Timer

## Properties

| Name | Type | Description | Default | Possible values |
| ----- |----- | ----- | ----- | ----- |
| precission | String | The timer will run at the interval of this millitime. | 's' | [m,s,100 ms] |
| reset | Null<Bool> | If true it will reset the timer to 0. If false, it will continue from where it was paused. | false | null |

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