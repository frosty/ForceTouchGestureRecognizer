# ForceTouchGestureRecognizer

A simple UIGestureRecognizer subclass that detects 3D touch.

## Usage

It's super simple. Create a `ForceTouchGestureRecognizer`, and add it to a view, as you would any other gesture recognizer:

    let recognizer = ForceTouchGestureRecognizer(target: self, action: "forceGestureRecognizerChanged:")
    view.addGestureRecognizer(recognizer)

You can optionally give the recognizer a `forceThreshold` – a normalized value at which the gesture should end. This defaults to 1.0 (the deepest touch possible):

    recognizer.forceThreshold = 0.8

The recognizer will report its state as `Changed` whenever the touch's force changes. It exposes a normalized version of the touch force through its `normalizedForce` property.

Once the `normalizedForce` reaches the `forceThreshold`, the gesture's state will change to `Ended`.
