/**
 * Copyright (C) 2000 - 2013 Silverpeas
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * As a special exception to the terms and conditions of version 3.0 of
 * the GPL, you may redistribute this Program in connection with Free/Libre
 * Open Source Software ("FLOSS") applications as described in Silverpeas's
 * FLOSS exception.  You should have received a copy of the text describing
 * the FLOSS exception, and it is also available here:
 * "http://www.silverpeas.org/docs/core/legal/floss_exception.html"
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package com.silverpeas.comment.service;

import com.silverpeas.comment.model.Comment;
import com.silverpeas.notification.NotificationPublisher;
import com.silverpeas.notification.NotificationSource;
import com.silverpeas.notification.SilverpeasNotification;

import javax.inject.Inject;

import static com.silverpeas.notification.NotificationTopic.onTopic;
import static com.silverpeas.notification.RegisteredTopics.COMMENT_TOPIC;
import static com.silverpeas.notification.SilverpeasNotificationCause.CREATION;
import static com.silverpeas.notification.SilverpeasNotificationCause.DELETION;

/**
 * A notifier of actions on comments. The notifier uses the Silverpeas notification API to inform
 * subscribers about actions on comments.
 */
public class CommentActionNotifier {

  @Inject
  private NotificationPublisher publisher;

  /**
   * Notifies the specified comment was added to a resource in Silverpeas.
   * @param addedComment the comment that was added.
   */
  public void notifyCommentAdding(final Comment addedComment) {
    NotificationSource source = new NotificationSource()
        .withComponentInstanceId(addedComment.getCommentPK().getInstanceId())
        .withUserId(String.valueOf(addedComment.getOwnerId()));
    SilverpeasNotification notification = new SilverpeasNotification(source, CREATION, addedComment);
    publisher.publish(notification, onTopic(COMMENT_TOPIC));
  }

  /**
   * Notifies the specified comment was removed from a resource in Silverpeas.
   * @param removedComment the comment that was removed.
   */
  public void notifyCommentRemoval(final Comment removedComment) {
    NotificationSource source = new NotificationSource()
        .withComponentInstanceId(removedComment.getCommentPK().getInstanceId())
        .withUserId(String.valueOf(removedComment.getOwnerId()));
    SilverpeasNotification notification = new SilverpeasNotification(source, DELETION, removedComment);
    publisher.publish(notification, onTopic(COMMENT_TOPIC));
  }
}
