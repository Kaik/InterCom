{* $Id$ *}
{* This template is used by intercom_block_messages_ajax.htm *}

{getmessages}

{if ($totalarray.unread > 0) || ($totalarray.totalin > 0)}
<dl>
    <dt>
        <a class="image {if $totalarray.unread > 0}mailunread{else}mailread{/if}" href="{modurl modname="InterCom" type="user" func="inbox"}" title="{gt text="New private messages" domain="module_intercom"}">
            [<strong>{$totalarray.unread}</strong>
            |<strong>{$totalarray.totalin}</strong>]
        {gt text="Inbox" domain="module_intercom"}</a>
    </dt>
</dl>
{/if}

<dl>
    {if $messages}
    <dt>{gt text="The newest messages" domain="module_intercom"}</dt>
    {section name=message loop=$messages}
    <dd><a class="image {if $messages[message].msg_read == 1}mailread{else}mailunread{/if}" href="{modurl modname="InterCom" type="user" func="readinbox" messageid=$messages[message].msg_id}" title="{$messages[message].msg_subject}"><strong>{$messages[message].msg_subject}</strong></a></dd>
    <dd>{gt text="Sender" domain="module_intercom"}: {$messages[message].fromuser|profilelinkbyuname}</dd>
    <dd>{$messages[message].msg_time|dateformat:"datetimebrief"}</dd>
    {/section}
    {else}
    <dt>{gt text="You currently have no messages." domain="module_intercom"}</dt>
    {/if}
</dl>

<dl>
    <dt><a class="image inbox" href="{modurl modname="InterCom" type="user" func="inbox"}" title="{gt text="Inbox" domain="module_intercom"}">{gt text="Inbox" domain="module_intercom"}</a></dt>
    <dt><a class="image newmsg" href="{modurl modname="InterCom" type="user" func="newpm"}" title="{gt text="New message" domain="module_intercom"}">{gt text="New message" domain="module_intercom"}</a></dt>
</dl>
