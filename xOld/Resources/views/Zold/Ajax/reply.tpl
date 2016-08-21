{* $Id$ *}
{capture assign="textfieldid"}ic-ajaxreplymessage-{$message.msg_id|safetext}{/capture}

<div class="z-formrow">
    <label for="subject">{gt text="Subject line" domain="module_intercom"}</label>
    <input type="text" name="ic-ajaxreplysubject-{$message.msg_id|safetext}" id="ic-ajaxreplysubject-{$message.msg_id|safetext}" maxlength="100" value="{replysubject subject=$message.msg_subject|replace:" ":""|truncate:3:"":true subjectclean=$message.msg_subject}" />
</div>

<div class="z-formrow">
    <label for="{$textfieldid}">{gt text="Message text" domain="module_intercom"}</label>
    <textarea id="{$textfieldid}" name="{$textfieldid}" class="ic_texpand">{$message.reply_text|safetext}</textarea>
</div>

<div class="z-clearfix ic-margin">
    {if $pncore.InterCom.messages_allowhtml eq 1 || $allowsmilies eq 1}
    <div class="ic-floatleft">
        {if $allowsmilies eq 1}
        {modfunc modname='BBSmile' func='bbsmiles' textfieldid=$textfieldid}
        {/if}
        {if $pncore.InterCom.messages_allowhtml eq 1}
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
    <a id="msg-sendreply-{$message.msg_id|safetext}"   href="javascript:void(0);">{img modname=core src=button_ok.png set=icons/extrasmall __alt="Send now" __title="Send now"} {gt text="Send now" domain="module_intercom"}</a>
    <a id="msg-cancelreply-{$message.msg_id|safetext}" href="javascript:void(0);">{img modname=core src=button_cancel.png set=icons/extrasmall __alt="Cancel" __title="Cancel"} {gt text="Cancel" domain="module_intercom"}</a>
</div>