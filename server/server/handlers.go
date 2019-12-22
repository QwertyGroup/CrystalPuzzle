package server

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

// QRequest represents questions request bundled with previous answers
type QRequest struct {
	N       int
	UserID  string
	Answers map[int]bool
}

// GetQues is hello world default route handler
func (s *Server) GetQues(w http.ResponseWriter, r *http.Request) {
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		log.Println(err)
	}
	defer r.Body.Close()
	var req QRequest
	err = json.Unmarshal(body, &req)
	if err != nil {
		log.Println(err)
	}
	log.Println(req)
	s.ReceiveAns(req.UserID, req.Answers)
	ques := s.GiveQuestions(req.UserID, req.N)
	quesj, err := json.Marshal(&ques)
	if err != nil {
		log.Println(err)
	}
	fmt.Fprintf(w, string(quesj))
}