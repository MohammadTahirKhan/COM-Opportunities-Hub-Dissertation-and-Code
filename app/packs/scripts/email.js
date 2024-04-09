// post_selection.js

document.addEventListener('DOMContentLoaded', function() {
    const checkboxes = document.querySelectorAll('.post-checkbox');
    const emailButton = document.querySelector('.btn-primary');
    let selectedPostIds = [];
  
    checkboxes.forEach(checkbox => {
      checkbox.addEventListener('change', function() {
        const postId = checkbox.value;
        if (checkbox.checked) {
          selectedPostIds.push(postId);
        } else {
          selectedPostIds = selectedPostIds.filter(id => id !== postId);
        }
        console.log('Selected Post IDs:', selectedPostIds); // Log selected post IDs
        emailButton.disabled = selectedPostIds.length === 0 || selectedPostIds.length > 10;
      });
    });
  });
  