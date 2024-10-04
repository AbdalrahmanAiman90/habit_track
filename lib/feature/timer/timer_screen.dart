import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

class TimerGoalScreen extends StatefulWidget {
  @override
  _TimerGoalScreenState createState() => _TimerGoalScreenState();
}

class _TimerGoalScreenState extends State<TimerGoalScreen> {
  int _timeStart = 0;
  int _timeLeft = 0;
  Timer? _timer;
  bool _isPaused = true;
  bool _isTimerRunning = false;

  TextEditingController _hoursController = TextEditingController();
  TextEditingController _minutesController = TextEditingController();
  TextEditingController _secondsController = TextEditingController();
  TextEditingController _goalController = TextEditingController();

  String? _goalError;
  String? _hoursError;
  String? _minutesError;
  String? _secondsError;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _isTimerRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0 && !_isPaused) {
        setState(() {
          _timeLeft--;
        });
      } else if (_timeLeft == 0) {
        _isTimerRunning = false;
        timer.cancel();
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isTimerRunning = !_isTimerRunning;
      _isPaused = !_isPaused;
    });
  }

  void _validateInput() {
    setState(() {
      int hours = int.tryParse(_hoursController.text) ?? 0;
      int minutes = int.tryParse(_minutesController.text) ?? 0;
      int seconds = int.tryParse(_secondsController.text) ?? 0;

      _hoursError = (hours < 0 || hours > 23) ? ' ' : null;
      _minutesError = (minutes < 0 || minutes > 59) ? ' ' : null;
      _secondsError = (seconds < 0 || seconds > 59) ? ' ' : null;

      if (hours == 0 && minutes == 0 && seconds == 0) {
        _hoursError =
            _minutesError = _secondsError = 'Enter at least one value';
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  TextInputFormatter _timeInputFormatter({required int maxValue}) {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) {
        return newValue;
      }

      final int? value = int.tryParse(newValue.text);

      if (value != null && value <= maxValue) {
        return newValue;
      }

      return oldValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Timer Goal',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: Size(200, 200),
                        painter: _timeStart == 0
                            ? TimerPainter(0)
                            : TimerPainter(_timeLeft / _timeStart),
                      ),
                      Text(
                        '${(_timeLeft ~/ 60).toString().padLeft(2, '0')}:${(_timeLeft % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.blue, size: 40),
                        onPressed: () {
                          setState(() {
                            _timeLeft = _timeStart;
                            _isPaused = true;
                          });
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF008bb7),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white, size: 40),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return _buildGoalModal(context);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          _isPaused ? Icons.play_arrow : Icons.pause,
                          color: Colors.blue,
                          size: 40,
                        ),
                        onPressed: _togglePause,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Short Goals History',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildHistoryItem('Pray 5 prayers', '30:05 min'),
                        _buildHistoryItem('Wake up early', '95:35 min'),
                        _buildHistoryItem('Wake up early', '95:35 min'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalModal(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Short Goal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _goalController,
              decoration: InputDecoration(
                labelText: 'Your Goal',
                border: OutlineInputBorder(),
                errorText: _goalError, // Display error if validation fails
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _hoursController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [_timeInputFormatter(maxValue: 23)],
                    decoration: InputDecoration(
                      labelText: 'Hours',
                      border: OutlineInputBorder(),
                      errorText: _hoursError,
                    ),
                    onChanged: (value) => _validateInput(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _minutesController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [_timeInputFormatter(maxValue: 59)],
                    decoration: InputDecoration(
                      labelText: 'Minutes',
                      border: OutlineInputBorder(),
                      errorText: _minutesError,
                    ),
                    onChanged: (value) => _validateInput(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _secondsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [_timeInputFormatter(maxValue: 59)],
                    decoration: InputDecoration(
                      labelText: 'Seconds',
                      border: OutlineInputBorder(),
                      errorText: _secondsError,
                    ),
                    onChanged: (value) => _validateInput(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Validate goal name
                  _goalError = _goalController.text.isEmpty
                      ? 'Goal name cannot be empty'
                      : null;

                  // Continue validating time inputs
                  _validateInput();

                  if (_hoursError == null &&
                      _minutesError == null &&
                      _secondsError == null &&
                      _goalError == null) {
                    int hours = int.tryParse(_hoursController.text) ?? 0;
                    int minutes = int.tryParse(_minutesController.text) ?? 0;
                    int seconds = int.tryParse(_secondsController.text) ?? 0;

                    int totalSeconds =
                        (hours * 3600) + (minutes * 60) + seconds;

                    setState(() {
                      _timeStart = totalSeconds;
                      _timeLeft = totalSeconds;
                    });

                    if (!_isTimerRunning) {
                      _isPaused = true;
                      _timer?.cancel();
                      _startTimer();
                    }

                    Navigator.of(context).pop(); // Close modal
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero, // To remove default padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.cyan],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String task, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(task, style: TextStyle(fontSize: 16)),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.green.withOpacity(0.1),
            ),
            child:
                Text(time, style: TextStyle(color: Colors.green, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double progress;

  TimerPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 30
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 30
      ..shader = LinearGradient(
        colors: [Colors.blueAccent, Colors.cyan],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
