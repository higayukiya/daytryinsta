import $ from 'jquery'
import axios from 'axios'

const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;

const appendNewComment = (comment) => {
    // var dataSet = $('.text_area_chil').data()
    // var userId = dataSet.userId
    // var userName = dataSet.userName
    // var userAvatar = dataSet.userAvatar

    $('.comments-container').append(
        `<div class="comments_area">
        <div class="comments_avatar"><img src='${comment.user.profile.avatar_comment_img}'</div>
        <div class="comments_username"><p>${comment.user.username}</p></div>
        <div class="timelines_comment"><P>${comment.content}</P></div>
        </>`
    )
}

document.addEventListener('DOMContentLoaded', () => {
    const timelinesId = $('.comments-container').attr('id')
    axios.get(`/api/timelines/${timelinesId}/comments`)
    .then((response) => {
        const comments = response.data
        comments.forEach((comment) => {
            appendNewComment(comment)
        })
    })

    $('.comment_img_btn').on("click", function () {
        const timelinesId = $('.comments-container').attr('id')


            const content = $('#comment_content').val()
            if (!content) {
                window.alert('コメントを入力してください')
            } else {
                axios.post(`/api/timelines/${timelinesId}/comments`, {
                    comment: {
                        content: content
                    }
                })
                    .then((res) => {
                        const comment = res.data
                        appendNewComment(comment)
                        $('#comment_content').val('')
                    })
            
            }
        
    })
})