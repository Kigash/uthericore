page 50034 "Member Activation"
{
    // version TL2.0

    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Category5,Category6,Category7,Category8';
    SourceTable = "Member Activation Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Activation Type"; Rec."Activation Type")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Current Member Status"; Rec."Current Member Status")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part("Member Activation Subform"; "Member Activation Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';
                Visible = IsVisibleSendApprovalRequest;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    IF ApprovalsMgmt.CheckMemberActivationDeactivationApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendMemberActivationDeactivationForApproval(Rec);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Visible = IsVisibleCancelApprovalRequest;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.OnCancelMemberActivationDeactivationApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        PageEditable;
        ShowActions;
    end;

    var
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;

    local procedure ShowActions()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleSendApprovalRequest := TRUE;
            IsVisibleCancelApprovalRequest := TRUE;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := TRUE;
        END;
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
        END;
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN
            CurrPage.EDITABLE := FALSE;
        IF Rec.Status = Rec.Status::Approved THEN
            CurrPage.EDITABLE := FALSE;
    end;
}

