public class ExerciseProvider {
  public static var `default` = ExerciseProvider()
  public static func just(_ exercise: Exercise) -> ExerciseProvider {
    return ExerciseProvider(exercises: [exercise])
  }
  private static let defaultExercises: [Exercise] = [
    E1(),
    E2(),
    E3(),
    E4(),
    E5(),
    E6(),
    E7(),
    E8(),
    E9(),
    E10(),
    E11(),
    E12(),
    E13(),
    E14(),
    E15(),
    E16(),
    E17(),
    E18(),
    E19(),
    E20(),
    E21(),
    E22(),
    E23(),
    E24(),
    E25(),
    E26(),
    E26B()
  ]
  
  private var exercises: [Exercise]
  
  private init(exercises: [Exercise] = ExerciseProvider.defaultExercises) {
    self.exercises = exercises
  }
  
  public func register(_ exercise: Exercise) {
    exercises.append(exercise)
  }
  
  public func run() {
    exercises.forEach { $0.run() }
  }
}
