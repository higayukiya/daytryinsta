// import $ from 'jquery'
// import axios from 'modules/axios'

// const handleFollowDisplay = (hasFollowed) => {
//   if (hasFollowed) {
//     $('.unfollow').removeClass('hidden')
//   } else {
//     $('.follow').removeClass('hidden')
//   }
// }

// document.addEventListener('DOMContentLoaded', () => {
//   const dataset = $('#account-show').data()
//   const accountId = dataset.accountId
//   const followerId = dataset.followerId
  
//   axios.get(`/accounts/${accountId}/follows/${followerId}`)
//     .then((response) => {
//       const hasFollowed = response.data.hasFollowed
//       handleFollowDisplay(hasFollowed)
//     })
  
//   $('.follow').on('click', () => {
//     axios.post(`/accounts/${accountId}/follows`)
//       .then((response) => {
//         if (response.data.status === 'ok') {
//           $('.follow').addClass('hidden')
//           $('.unfollow').removeClass('hidden')
          
//           // $('.follower-count').html("${user.followers.count}")
//           // $('.follower-count').text(Number($('.follower-count').text())+1)
//         }
//       })
//       .catch((e) => {
//         window.alert('Error')
//         console.log(e)
//       })
//   })

//   $('.unfollow').on('click', () => {
//     axios.post(`/accounts/${accountId}/unfollows`)
//       .then((response) => {
//         if (response.data.status === 'ok') {
//           $('.unfollow').addClass('hidden')
//           $('.follow').removeClass('hidden')

//           // $('.follower-count').html("${user.followers.count}")
//           // $('#follower-count').text(Number($('#follower-count').text())-1)
//         }
//       })
//       .catch((e) => {
//         window.alert('Error')
//         console.log(e)
//       })
//   })  
// })
