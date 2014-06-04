(function(global, d) {
	var startNumber = "0",
		formattedStartNumber = [],
		endNumber = 0,
		img = 'flippyNum.png',
		numWidth = 29,
		numHeight = 40,
		element,
		ul,
		li = [],
		digits = 6,
		duration = 9000,
		
		changePositions = function(number, digit) {
			li[digit].style.backgroundPosition = "-" + (numWidth * number) + "px 0";
		},
		
		// add digit to the DOM
		addDigit = function() {
			var digit = d.createElement("li"),
				position = li.length;
			
			digit.style.background = "url(" + img + ")";
			digit.style.width = numWidth + "px";
			digit.style.height = numHeight + "px";
			digit.style.cssFloat = "left";
			// for ie:
			digit.style.styleFloat = "left";
			
			li.push(digit);
			
			changePositions(parseInt(formattedStartNumber[position], 10), position);
			
			ul.appendChild(digit);
		},
		
		// add UL to the DOM
		createBase = function() {
			var newUl = d.createElement("ul");
			
			newUl.style.overflow = "hidden";			
			ul = newUl;
			
			for (var i = 0; i < digits; i++) {
				addDigit();
			}
			
			element.appendChild(ul);
		},
		
		addAPriorNum = function(digit, isNeg) {
			var num = parseInt(formattedStartNumber[digit], 10),
				prev = parseInt(formattedStartNumber[digit - 1], 10),
				a;
			
			if (num === 9 && (!isNeg)) {				
				formattedStartNumber[digit] = "0";
				prev = addAPriorNum(digit - 1);
				changePositions(prev, digit - 1);
				formattedStartNumber[digit - 1] = parseInt(formattedStartNumber[digit - 1], 10).toString();
				return 0;
			} else if (num === 0 && (isNeg)) {
				formattedStartNumber[digit] = "9";
				prev = addAPriorNum(digit - 1, true);
				changePositions(prev, digit - 1);
				formattedStartNumber[digit - 1] = prev.toString();
				
				return 9;
			} else if (isNeg === true) {
				formattedStartNumber[digit] = (num - 1).toString();
				
				return formattedStartNumber[digit];
			} else if (digit > -1) {
				formattedStartNumber[digit] = (num + 1).toString();
				
				return num + 1;
			}
		},
		
		flipToNum = function(n, skip_duration) {
			var dur,
				b = parseInt(startNumber, 10),
				priorNum;
			
			if (skip_duration) {
				dur = 1;
			} else {
				if (n > b) {
					dur = duration / (n - b);
				} else {
					dur = duration / (b - n);
				}
			}
			
			if (n > startNumber) {
				for(var i = 0; b <= n; b++, i++) {
				    (function(b, i) {
				        setTimeout(function() {
				            if ((b % 10) === 0 && i !== 0) {
								priorNum = addAPriorNum(digits - 2);
								
								changePositions(priorNum, digits - 2);
							}
							changePositions((b % 10), digits - 1);
				        }, (i * dur));
				    }(b, i));
				}
			} else {
				for(var g = 0; b > n; b--, g++) {
					(function(b, g) {
						setTimeout(function() {
							if ((b % 10) === 0) {
								priorNum = addAPriorNum(digits - 2, true);
								
								changePositions(priorNum, digits - 2);
								changePositions(9, digits - 1);
							} else {
								changePositions((b % 10) - 1, digits - 1);
							}
				        }, (g * 100));
				    }(b, g));
				}
			}
			
			startNumber = n.toString();
                        return startNumber;
		},
		
		addOne = function() {
			flipToNum(parseInt(startNumber, 10) + 1, true);
                        return startNumber;
		},
		
		setStartNumber = function() {
			var diff = digits - startNumber.length;
			
			if (diff > 0) {
				for(var i = 0; i < diff; i++) {
					formattedStartNumber.push("0");
				}
			}
			formattedStartNumber = formattedStartNumber.concat(startNumber.split(''));
		},
		
		flippyNum = function(el, options) {
			element = el || document.body;
			options = options || {};
			
			if (options.width) numWidth = options.width;
			if (options.height) numHeight = options.height;
			if (options.digits) digits = options.digits;
			if (options.startNumber) startNumber = options.startNumber.toString();
			if (options.endNumber) endNumber = options.endNumber;
			if (options.duration) duration = options.duration;
			if (options.imagePath) img = options.imagePath;

			
			setStartNumber();
			createBase();
			flipToNum(endNumber);
			
			return {
				flipTo: flipToNum,
				addOne: addOne
			};
		};
		
		global.flippyNum = flippyNum;
}(window, document));
