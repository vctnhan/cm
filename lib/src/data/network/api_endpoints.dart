class ApiEndpoints {
  // // Base
  // static const String baseUrl = '/api/v1';

  // ========== AUTHENTICATION ==========
  static const String requestOtp = '/auth/otp/request';
  static const String verifyOtp = '/auth/otp/verify';
  static const String switchOrg = '/auth/switch-org';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';

  // ========== USER ==========
  static const String me = '/me';
  static const String updateMe = '/me';
  static const String uploadAvatar = '/me/avatar';
  static const String myOrganizations = '/me/organizations';
  static const String myDevices = '/me/devices';
  static String revokeDevice(String deviceId) => '/me/devices/$deviceId';

  static const String myThreads = '/me/threads';
  static const String mySettings = '/me/settings';
  static const String myUnreadCounts = '/me/unread-counts';
  static const String myMentions = '/me/mentions';
  static const String markMentionsRead = '/me/mentions/read';

  // ========== ORGANIZATION ==========
  static String organization(String orgId) => '/organizations/$orgId';
  static String departments(String orgId) =>
      '/organizations/$orgId/departments';

  // ========== USER DIRECTORY ==========
  static const String users = '/users';
  static String userDetail(String orgMemberId) =>
      '/users/$orgMemberId';

  static const String syncContacts = '/me/contacts/sync';

  // ========== CHANNEL ==========
  static const String channels = '/channels';
  static const String publicChannels = '/channels/public';
  static String channelDetail(String channelId) =>
      '/channels/$channelId';

  static String updateChannel(String channelId) =>
      '/channels/$channelId';

  static String deleteChannel(String channelId) =>
      '/channels/$channelId';

  static String archiveChannel(String channelId) =>
      '/channels/$channelId/archive';

  static String unarchiveChannel(String channelId) =>
      '/channels/$channelId/unarchive';

  static String joinChannel(String channelId) =>
      '/channels/$channelId/join';

  static String leaveChannel(String channelId) =>
      '/channels/$channelId/leave';

  static String channelMembers(String channelId) =>
      '/channels/$channelId/members';

  static String updateMemberRole(
      String channelId,
      String orgMemberId,
      ) =>
      '/channels/$channelId/members/$orgMemberId';

  static String notificationSettings(String channelId) =>
      '/channels/$channelId/notification';

  static String channelFiles(String channelId) =>
      '/channels/$channelId/files';

  static String channelLinks(String channelId) =>
      '/channels/$channelId/links';

  // ========== MESSAGE ==========
  static String channelMessages(String channelId) =>
      '/channels/$channelId/messages';

  static String syncMessages(String channelId) =>
      '/channels/$channelId/messages/sync';

  static String markMessagesRead(String channelId) =>
      '/channels/$channelId/read';

  static String messageDetail(String messageId) =>
      '/messages/$messageId';

  static String editMessage(String messageId) =>
      '/messages/$messageId';

  static String deleteMessage(String messageId) =>
      '/messages/$messageId';

  static String forwardMessage(String messageId) =>
      '/messages/$messageId/forward';

  // ========== REACTIONS ==========
  static String addReaction(String messageId) =>
      '/messages/$messageId/reactions';

  static String removeReaction(String messageId, String emojiCode) =>
      '/messages/$messageId/reactions/$emojiCode';

  // ========== THREAD ==========
  static String threadMessages(String messageId) =>
      '/messages/$messageId/thread';

  static String replyThread(String messageId) =>
      '/messages/$messageId/thread';

  static String markThreadRead(String messageId) =>
      '/messages/$messageId/thread/read';

  // ========== FILE ==========
  static const String getUploadUrl = '/files/upload-url';
  static String completeUpload(String fileId) =>
      '/files/$fileId/complete';

  static String getDownloadUrl(String fileId) =>
      '/files/$fileId/download-url';

  static String deleteFile(String fileId) =>
      '/files/$fileId';

  // ========== PINNED MESSAGE ==========
  static String pinnedMessages(String channelId) =>
      '/channels/$channelId/pins';

  static String pinMessage(String channelId) =>
      '/channels/$channelId/pins';

  static String unpinMessage(String channelId, String messageId) =>
      '/channels/$channelId/pins/$messageId';

  // ========== POLL ==========
  static String createPoll(String channelId) =>
      '/channels/$channelId/polls';

  static String votePoll(String pollId) =>
      '/polls/$pollId/vote';

  static String unvotePoll(String pollId) =>
      '/polls/$pollId/vote';

  static String closePoll(String pollId) =>
      '/polls/$pollId/close';

  // ========== FOLDER ==========
  static const String myFolders = '/me/folders';

  static String updateFolder(String folderId) =>
      '/me/folders/$folderId';

  static String deleteFolder(String folderId) =>
      '/me/folders/$folderId';

  static String addChannelToFolder(String folderId) =>
      '/me/folders/$folderId/channels';

  static String removeChannelFromFolder(
      String folderId,
      String channelId,
      ) =>
      '/me/folders/$folderId/channels/$channelId';

  // ========== PROJECT ==========
  static const String projects = '/projects';

  static String projectChannels(String projectId) =>
      '/projects/$projectId/channels';

  // ========== WEBHOOK / BOT ==========
  static String channelWebhooks(String channelId) =>
      '/channels/$channelId/webhooks';

  static String incomingWebhook(String token) =>
      '/webhooks/$token';

  // ========== STICKER ==========
  static const String stickerPacks = '/sticker-packs';

  static String stickers(String packId) =>
      '/sticker-packs/$packId/stickers';

  // ========== SEARCH ==========
  static const String search = '/search';
}
