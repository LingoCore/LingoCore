import { LessonSessionRepository } from "../repositories/lessonSession.js";

/** @type {import("express").RequestHandler} */
export const sessionStart = async (req, res) => {
    const { lessonId } = req.body;
    const userId = req.user.id;
    const repo = new LessonSessionRepository();
    try {
        const sessionId = await repo.startSession(userId, lessonId);
        return res.status(200).json({ message: "Session started successfully", sessionId });
    } catch (e) {
        console.log(e)
        return res.status(500).json({ message: e.toString() });
    }
}

/** @type {import("express").RequestHandler}  */
export const sessionGet = async (req, res) => {
    const { sessionId } = req.params;
    const userId = req.user.id;
    const repo = new LessonSessionRepository();
    try {
        const state = await repo.getState(sessionId);
        return res.status(200).json({ message: "Session state retrieved successfully", state });
        
    } catch (e) {
        console.log(e)
        return res.status(500).json({ message: e.toString() });
    }    
}

/** @type {import("express").RequestHandler}  */
export const sessionPost = async (req, res) => {
    const { sessionId } = req.params;
    const { answer } = req.body;
    const userId = req.user.id;
    const repo = new LessonSessionRepository();
    try {
        const {isCorrect, correctAnswer} = await repo.answerQuestion(sessionId, answer);
        return res.status(200).json({ message: "Answer submitted successfully", isCorrect, correctAnswer });
    } catch (e) {
        console.log(e)
        return res.status(500).json({ message: e.toString() });   
    }
}