page 50094 "Teller Return Treasury Card"
{
    Caption = 'Teller Receive From/Return To Treasury Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Teller Return Treasury";
    Editable = true;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Category5,Category6,Category7,Category8';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Treasury Account No."; Rec."Treasury Account No.")
                {
                    ApplicationArea = All;

                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                group(Return)
                {
                    Visible = Rec."Transaction Type" = 2;
                    field("Till Return Amount"; Rec."Till Return Amount")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Receive)
                {
                    Visible = Rec."Transaction Type" = 1;
                    field("Till Receive Amount"; Rec."Till Receive Amount")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Total Coinage Amount"; Rec."Total Coinage Amount")
                {
                    ApplicationArea = All;
                }
                field("Teller User ID"; Rec."Teller User ID")
                {
                    ApplicationArea = All;
                }
                field("Till No."; Rec."Till No.")
                {
                    ApplicationArea = All;

                }
                field("Till Balance"; Rec."Till Balance")
                {
                    ApplicationArea = All;

                }
                field("Till Maximum Limit"; Rec."Till Maximum Limit")
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;

                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;

                }
                field("Teller Host IP"; Rec."Teller Host IP")
                {
                    ApplicationArea = All;

                }
                field("Teller Host MAC"; Rec."Teller Host MAC")
                {
                    ApplicationArea = All;

                }
                field("Teller Host Name"; Rec."Teller Host Name")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
            }
            group(TransactionCoinage)
            {
                Caption = 'Transaction Coinage';
                Visible = true;
                part("Transaction Coinage Setup"; "Transaction Coinage Setup")
                {
                    ApplicationArea = All;
                    UpdatePropagation = Both;
                    SubPageLink = "Transaction No." = field("No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Post;
                Visible = IsVisiblePost;

                trigger OnAction();
                begin
                    if Confirm(PostConfirmMsg, true) then begin
                        if Rec."Transaction Type" = Rec."Transaction Type"::"Return To Treasury" then
                            TelleringTreasury.PostTellerReturnToTreasury(Rec);
                        if Rec."Transaction Type" = Rec."Transaction Type"::"Receive From Treasury" then
                            TelleringTreasury.PostTellerReceiveFromTreasury(Rec);
                    end else
                        exit;
                end;
            }
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
                    Rec.CalcFields("Total Coinage Amount");
                    if Rec."Transaction Type" = Rec."Transaction Type"::"Return To Treasury" then
                        If Rec."Total Coinage Amount" <> Rec."Till Return Amount" then
                            Error('Return amount must match total coinage amount');

                    if Rec."Transaction Type" = Rec."Transaction Type"::"Receive From Treasury" then
                        If Rec."Total Coinage Amount" <> Rec."Till Receive Amount" then
                            Error('Receive amount must match total coinage amount');


                    IF ApprovalsMgmt.CheckTellerReturnTreasuryApprovalPossible(Rec) THEN begin
                        ApprovalsMgmt.OnSendTellerReturnTreasuryForApproval(Rec);
                        CurrPage.Close();
                    end;
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
                    ApprovalsMgmt.OnCancelTellerReturnTreasuryApprovalRequest(Rec);
                end;
            }
            action(Approve)
            {
                ApplicationArea = Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Approve the requested changes.';
                Visible = IsVisibleApprove;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(Reject)
            {
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';
                Visible = IsVisibleReject;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(Delegate)
            {
                ApplicationArea = Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = IsVisibleDelegate;


                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                    END;
                    CurrPage.CLOSE;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetVisible;
        SetEditable;
    end;

    local procedure SetVisible()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleSendApprovalRequest := TRUE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
            IsVisiblePost := false;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleApprove := true;
            IsVisibleDelegate := true;
            IsVisibleReject := true;
            IsVisiblePost := false;
        END;
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
            if Rec.Posted = false then
                IsVisiblePost := true
            else
                IsVisiblePost := false;
        END;
        IF Rec.Status = Rec.Status::Rejected THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
            IsVisiblePost := false;
        END;
    end;

    local procedure SetEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN
            CurrPage.EDITABLE := FALSE;
        IF Rec.Status = Rec.Status::Approved THEN
            CurrPage.EDITABLE := FALSE;
    end;

    var
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleApprove: Boolean;
        IsVisibleReject: Boolean;
        IsVisibleDelegate: Boolean;
        IsVisiblePost: Boolean;
        TelleringTreasury: Codeunit "Tellering & Treasury";
        PostConfirmMsg: Label 'Do you want to post this transaction?';
}