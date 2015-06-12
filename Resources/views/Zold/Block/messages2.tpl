{* $Id$ *}

{pageaddvar name="stylesheet" value="modules/InterCom/style/style.css"}
{getmessages}

<div class="intercomblock">
    <ul>
        <li>
            <a class="image {if $totalarray.unread > 0}mailunread{else}mailread{/if}" href="{modurl modname="InterCom" type="user" func="inbox"}" title="{gt text="New private messages" domain="module_intercom"}">
                <strong>[{$totalarray.unread}|{$totalarray.totalin}]</strong>&nbsp;{gt text="Messages" domain="module_intercom"}
            </a>
        </li>
        <li><a class="image inbox" href="{modurl modname="InterCom" type="user" func="inbox"}" title="{gt text="Inbox" domain="module_intercom"}">{gt text="Inbox" domain="module_intercom"}</a></li>
        <li><a class="image newmsg" href="{modurl modname="InterCom" type="user" func="newpm"}" title="{gt text="New message" domain="module_intercom"}">{gt text="New message" domain="module_intercom"}</a></li>
    </ul>
</div>
