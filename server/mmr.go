package server

import (
	"fmt"
	"math"
)

var max int = 10000
var min int = 0
var maxUserDif float64 = 1500
var maxQuestionDif float64 = 50
var secNorm float64 = 100
var smoothness float64 = 4
var winRate float64 = 0.6

func ChangeRate(q *Question, u *User, a *AnswerInf) {
	ud, qd := CountRateChange(q, u, a)
	q.MMR += int(qd)
	u.MMR += int(ud)
	if u.MMR > max {
		u.MMR = max
	}
	if q.MMR > max {
		q.MMR = max
	}
	if u.MMR < min {
		u.MMR = min
	}
	if q.MMR < min {
		q.MMR = min
	}
}

func CountRateChange(q *Question, u *User, a *AnswerInf) (ud float64, qd float64) {
	result := countResult(a)
	diffCoeff := countRateDiffCoeff(q.MMR, u.MMR)
	//fmt.Println("diffCoeff:", diffCoeff)
	// fmt.Println(u)
	// fmt.Println(q)

	if (result > 0) == (u.MMR > q.MMR) {
		result *= diffCoeff
	} else {
		result *= 2 - diffCoeff
	}

	ud = result * float64(maxUserDif)
	qd = -result * float64(maxQuestionDif)
	if result > 0 {
		ud *= 1 - winRate
		qd *= 1 - winRate
	} else {
		ud *= winRate
		qd *= winRate
	}
	return
}

//checked
func countResult(answer *AnswerInf) float64 {
	if answer.Tries < 0 {
		return -1
	}
	return -sigmoidRemake(smoothness*float64(answer.Seconds)/secNorm - smoothness)
}

func countRateDiffCoeff(qmmr int, ummr int) float64 {
	dif := float64(qmmr - ummr)
	//fmt.Println("dif: ", dif)
	fmt.Println(1 / math.Pow(math.E, dif*dif/maxUserDif/maxUserDif))
	return 1 / math.Pow(math.E, dif*dif/maxUserDif/maxUserDif)
}

func sigmoidRemake(x float64) float64 {
	epowx := math.Pow(math.E, float64(x))
	return (epowx/(1+epowx) - 0.5) * 2
}
