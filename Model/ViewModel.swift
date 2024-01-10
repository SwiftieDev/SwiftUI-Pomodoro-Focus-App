//
//  ViewModel.swift
//  PomodoroFocus
//
//  Created by SwiftieDev
//

import Foundation

class ViewModel: ObservableObject {
    @Published var workDuration = 25
    @Published var shortBreakDuration = 5
    @Published var longBreakDuration = 10
    @Published var workTimerMode: TimerMode = .initial
    @Published var shortBreakTimerMode: TimerMode = .initial
    @Published var longBreakTimerMode: TimerMode = .initial
    @Published var workTimeRemaining = 25 * 60
    @Published var shortBreakTimeRemaining = 5 * 60
    @Published var longBreakTimeRemaining = 10 * 60
    @Published var workTimer: Timer?
    @Published var breakTimer: Timer?
    
    enum TimerMode {
        case initial
        case running
        case paused
    }
    
    func startWorkTimer() {
        workTimer?.invalidate()
        workTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.workTimeRemaining > 0 {
                self.workTimeRemaining -= 1
            } else {
                self.workTimer?.invalidate()
                if self.workTimerMode == .running {
                    self.workTimerMode = .paused
                }
            }
        }
        workTimerMode = .running
    }
    
    func startShortBreakTimer() {
        breakTimer?.invalidate()
        breakTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.shortBreakTimeRemaining > 0 {
                self.shortBreakTimeRemaining -= 1
            } else {
                self.breakTimer?.invalidate()
                if self.shortBreakTimerMode == .running {
                    self.shortBreakTimerMode = .paused
                }
            }
        }
        shortBreakTimerMode = .running
    }
    
    func startLongBreakTimer() {
        breakTimer?.invalidate()
        breakTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.longBreakTimeRemaining > 0 {
                self.longBreakTimeRemaining -= 1
            } else {
                self.breakTimer?.invalidate()
                if self.longBreakTimerMode == .running {
                    self.longBreakTimerMode = .paused
                }
            }
        }
        longBreakTimerMode = .running
    }
    
    func pauseTimers() {
        workTimer?.invalidate()
        breakTimer?.invalidate()
        workTimerMode = .paused
        shortBreakTimerMode = .paused
        longBreakTimerMode = .paused
    }
    
    func resetTimers() {
        workTimer?.invalidate()
        breakTimer?.invalidate()
        workTimerMode = .initial
        shortBreakTimerMode = .initial
        longBreakTimerMode = .initial
        workTimeRemaining = workDuration * 60
        shortBreakTimeRemaining = shortBreakDuration * 60
        longBreakTimeRemaining = longBreakDuration * 60
    }
    
    func secondsToMinutesAndSeconds(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func advanceOneMinuteForward() {
        let oneMinute = 60
        
        switch (workTimerMode, shortBreakTimerMode, longBreakTimerMode) {
        case(.running, _, _): workTimeRemaining += oneMinute
        case(_, .running, _): shortBreakTimeRemaining += oneMinute
        case(_, _, .running): longBreakTimeRemaining += oneMinute
        default: resetTimers()
        }
    }
}
