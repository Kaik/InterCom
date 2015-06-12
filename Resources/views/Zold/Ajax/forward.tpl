{* $Id$ *}
{capture assign="textfieldid"}ic-ajaxforwardmessage-{$message.msg_id|safetext}{/capture}

<ol>
    <li class="z-formrow">
        <label for="username">{gt text="Individual recipient(s)" domain="module_intercom"}</label>
        <div class="ic-inputbox-username">
            <input id="username" name="to_user" type="text" />
            <div id="list-user">
                <div class="default">{gt text="Notice: To send a private message to multiple individual recipients, enter their user names separated by commas." domain="module_intercom"}</div>
                <ul class="feed"></ul>
            </div>
        </div>
    </li>
</ol>

<script type="text/javascript">
    // init
    tlist1 = new FacebookList('username', 'list-user',{fetchFile:document.location.pnbaseURL + 'ajax.php?module=InterCom&func=getusers'});
</script>

<div class="z-formrow">
    <label for="subject">{gt text="Subject line" domain="module_intercom"}</label>
    <input type="text" name="ic-ajaxforwardsubject-{$message.msg_id|safetext}" id="ic-ajaxforwardsubject-{$message.msg_id|safetext}" maxlength="100" value="{forwardsubject subject=$message.msg_subject|replace:" ":""|truncate:3:"":true subjectclean=$message.msg_subject}" />
</div>

<div class="z-formrow">
    <label for="{$textfieldid}">{gt text="Message text" domain="module_intercom"}</label>
    <textarea id="{$textfieldid}" name="{$textfieldid}" class="ic_texpand" id="{$textfieldid}">{$message.forward_text|safetext}</textarea>
</div>

<div class="z-clearfix ic-margin">
    {if $allowhtml eq 1 || $allowsmilies eq 1}
    <div class="ic-floatleft">
        {if $allowsmilies eq 1}
        {modfunc modname='BBSmile' func='bbsmiles' textfieldid=$textfieldid}
        {/if}
        {if $allowhtml eq 1}
        <br />
        <label for="html">{gt text="Disable HTML mark-up" domain="module_intercom"}</label>
        <input type="checkbox" id="html" name="html" value="1" {if $html eq 1}checked="true"{/if} />
        {/if}
    </div>
    {/if}

    {if $allowbbcode eq 1}
    <div class="ic-floatright">
        {modfunc modname='BBCode' type='user' func='bbcodes' textfieldid=$textfieldid images=0}
    </div>
    {/if}
</div>

<div class="ic-buttons ic-margin">
    <a id="msg-sendforward-{$message.msg_id|safetext}"   href="javascript:void(0);">{img modname=core src=button_ok.png set=icons/extrasmall __alt="Forward message now" __title="Forward message now"} {gt text="Forward message now" domain="module_intercom"}</a>
    <a id="msg-cancelforward-{$message.msg_id|safetext}" href="javascript:void(0);">{img modname=core src=button_cancel.png set=icons/extrasmall __alt="Cancel" __title="Cancel"} {gt text="Cancel" domain="module_intercom"}</a>
</div>