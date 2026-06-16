page 50370 "Agent Application"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Agent Application";
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
                field("Agent Type"; Rec."Agent Type")
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
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Vendor: Record vendor;
                        AccountType: Record "Account Type";
                        BankAccount: Record "Bank Account";
                    begin
                        // if "Account Type" = "Account Type"::Vendor then begin
                        //     Vendor.Reset();
                        //     Vendor.SetRange("Member No.", "Member No.");
                        //     IF PAGE.RUNMODAL(50100, Vendor) = ACTION::LookupOK THEN begin
                        //         if AccountType.Get(Vendor."Account Type") then begin
                        //             if AccountType.Type <> AccountType.Type::Savings then
                        //                 Error(NotSavingsAccErr)
                        //             else begin
                        //                 "Account No." := Vendor."No.";
                        //                 "Account Name" := Vendor.Name
                        //             end;
                        //         end;
                        //     end;
                        // end;
                        if Rec."Account Type" = Rec."Account Type"::"Bank Account" then begin
                            BankAccount.Reset();
                            //Vendor.SetRange("Member No.", "Member No.");
                            IF PAGE.RUNMODAL(371, BankAccount) = ACTION::LookupOK THEN begin
                                Rec."Account No." := BankAccount."No.";
                                Rec."Account Name" := BankAccount.Name
                            end;
                        end;
                    end;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Device Phone No."; Rec."Device Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Device Serial No."; Rec."Device Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = All;
                }
                field("Allow Withdrawal"; Rec."Allow Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Allow Desposit"; Rec."Allow Deposit")
                {
                    ApplicationArea = All;
                }
                field("Allow Balance Inquiry"; Rec."Allow Balance Inquiry")
                {
                    ApplicationArea = All;
                }
                field("Allow Ministatement"; Rec."Allow Ministatement")
                {
                    ApplicationArea = All;
                }
                field("Allow Airtime"; Rec."Allow Airtime")
                {
                    ApplicationArea = All;
                }
                field("Allow Utility Services"; Rec."Allow Utility Services")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group(Audit)
            {
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
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
                    Rec.TestField("Member No.");
                    Rec.TestField("Account No.");
                    Rec.TestField("Phone No.");
                    Rec.TestField("Device Phone No.");
                    Rec.TestField("Device Serial No.");
                    Rec.TestField("Business Name");
                    IF ApprovalsMgmt.CheckAgentApplicationApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendAgentApplicationForApproval(Rec);
                    CurrPage.Close();
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
                    ApprovalsMgmt.OnCancelAgentApplicationApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
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

    var
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleApprove: Boolean;
        IsVisibleReject: Boolean;
        IsVisibleDelegate: Boolean;
        NotSavingsAccErr: TextConst ENU = 'Account selected is not a Savings a/c';

    local procedure SetVisible()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleSendApprovalRequest := TRUE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleApprove := true;
            IsVisibleDelegate := true;
            IsVisibleReject := true;
        END;
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
        END;
        IF Rec.Status = Rec.Status::Rejected THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
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
}

