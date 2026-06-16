page 51160 "Teller Transaction Card Posted"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Teller Transaction Header";
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Category5,Category6,Category7,Category8';
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    layout
    {
        area(Content)
        {
            group(Teller)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
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
                field("Teller User ID"; Rec."Teller User ID")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Till No."; Rec."Till No.")
                {
                    ApplicationArea = All;
                }
                field("Till Name"; Rec."Till Name")
                {
                    ApplicationArea = All;
                }
                field("Till Balance"; Rec."Till Balance")
                {
                    ApplicationArea = All;
                }
                field("Total Coinage Amount"; Rec."Total Coinage Amount")
                {
                    ApplicationArea = All;

                }
                field("Teller Host IP"; Rec."Teller Host IP")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Teller Host MAC"; Rec."Teller Host MAC")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Teller Host Name"; Rec."Teller Host Name")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }

                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;

                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;

                }

            }
            part("Teller Transaction Subform"; "Teller Transaction Subform")
            {
                ApplicationArea = All;
                UpdatePropagation = Both;
                SubPageLink = "Transaction No." = field("No.");
            }

            group(TransactionCoinage)
            {
                Caption = '';
                Visible = Rec."Coinage Breakdown" = true;
                part("Transaction Coinage Setup"; "Transaction Coinage Setup")
                {
                    ApplicationArea = All;
                    UpdatePropagation = Both;
                    SubPageLink = "Transaction No." = field("No."), "Coinage Source" = filter(Teller);
                }
            }
        }
        area(factboxes)
        {
            part(TellerMemberStatistics2; "Teller Member Statistics")
            {
                ApplicationArea = All;
                SubPageLink = "Transaction No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(Post)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Post;
                Visible = Rec.Posted = false;

                trigger OnAction();
                var
                    BOSAManagement: Codeunit "BOSA Management";

                begin
                    Rec.ValidateTellerTransaction();
                    if Confirm(PostConfirmMsg, true) then begin
                        TelleringTreasury.PostTellerTransaction(Rec);
                        BOSAManagement.SendTellerTransactionNotification(Rec);
                        CurrPage.Close();
                    end else
                        exit;
                end;
            }


            /*action(Reverse)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReverseLines;
                Visible = Rec.Posted = true;

                trigger OnAction();
                var
                    ReversalEntry: Record "Reversal Entry";
                begin
                    if Confirm(ReverseConfirmMsg, true) then begin
                        GLEntry.Reset();
                        GLEntry.SetRange("Document No.", Rec."No.");
                        GLEntry.SetRange(Reversed, false);
                        if GLEntry.FindSet() then begin
                            repeat
                                ReversalEntry.SetHideWarningDialogs();
                                ReversalEntry.SetHideDialog(true);
                                ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");
                            until GLEntry.Next() = 0;
                        end;
                    end;
                    Rec.Reversed := true;
                    if Rec.Modify() then
                        Message(ReversalSuccessMsg, Rec."No.");
                end;
            }*/

            action(Reverse)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReverseLines;
                Visible = Rec.Posted = true;

                trigger OnAction()
                var
                    ReversalEntry: Record "Reversal Entry";
                    BOSAManagement: Codeunit "BOSA Management";
                begin
                    if Confirm(ReverseConfirmMsg, true) then begin
                        GLEntry.Reset();
                        GLEntry.SetRange("Document No.", Rec."No.");
                        GLEntry.SetRange(Reversed, false);

                        if GLEntry.FindSet() then begin
                            repeat
                                ReversalEntry.SetHideWarningDialogs();
                                ReversalEntry.SetHideDialog(true);
                                ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");
                            until GLEntry.Next() = 0;
                        end;

                        Rec.Reversed := true;
                        Rec.Posted := false;
                        Rec.Status := Rec.Status::New;
                        Rec.Modify(true);

                        BOSAManagement.SendTellerReversalNotification(Rec);

                        Message(ReversalSuccessMsg, Rec."No.");
                    end;
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
                Visible = false;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    IF ApprovalsMgmt.CheckTellerTransactionApprovalPossible(Rec) THEN begin
                        ApprovalsMgmt.OnSendTellerTransactionForApproval(Rec);
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
                Visible = false;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.OnCancelTellerTransactionApprovalRequest(Rec);
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
                Visible = false;

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
                Visible = false;

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
                Visible = false;


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
        area(Reporting)
        {
            action(Print)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction();
                begin
                    TellerTransactionHeader.GET(Rec."No.");
                    TellerTransactionHeader.SETRECFILTER;
                    Report.Run(50004, true, false, TellerTransactionHeader);
                end;
            }
        }

    }
    trigger OnOpenPage()
    begin
        SetVisible;
        SetEditable;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin

    end;

    local procedure SetVisible()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            begin
                if Rec.Posted then begin
                    IsVisibleSendApprovalRequest := false;
                    IsVisibleCancelApprovalRequest := FALSE;

                end else begin
                    IsVisibleSendApprovalRequest := true;
                    IsVisibleCancelApprovalRequest := false;
                end;
                IsVisibleApprove := false;
                IsVisibleDelegate := false;
                IsVisibleReject := false;
                if Rec.Posted then
                    IsVisiblePost := false
                else
                    IsVisiblePost := true
            END;
        end;
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
            IsVisiblePost := true;
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
        IF Rec.Status = Rec.Status::New THEN begin
            if Rec.Posted then
                CurrPage.EDITABLE := false
            else
                CurrPage.EDITABLE := true;
        end;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN
            CurrPage.EDITABLE := FALSE;
        IF Rec.Status = Rec.Status::Approved THEN
            CurrPage.EDITABLE := FALSE;
    end;



    var
        TelleringTreasury: Codeunit "Tellering & Treasury";
        TellerTransactionHeader: Record "Teller Transaction Header";
        PostConfirmMsg: Label 'Do you want to post this transaction?';
        ReverseConfirmMsg: Label 'Do you want to reverse this transaction?';
        ReversalSuccessMsg: Label 'Transaction %1 reversed successfully';
        GLEntry: Record "G/L Entry";
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleApprove: Boolean;
        IsVisibleReject: Boolean;
        IsVisibleDelegate: Boolean;
        IsVisiblePost: Boolean;


}