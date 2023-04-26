from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/add', methods=['POST'])
def add():
    # Retrieve inputs from request
    a = request.json['a']
    b = request.json['b']

    # Call Python code to add the numbers
    result = subprocess.check_output(['python', 'attendance.py', str(a), str(b)])

    # Convert output to string and remove any newlines
    result_str = result.decode('utf-8').strip()

    # Return result as JSON response
    return jsonify({'result': result_str})

if __name__ == '__main__':
    app.run(debug=True)