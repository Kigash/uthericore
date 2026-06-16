page 50270 "Guarantor Substitution"
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Related Information,Posting,Category7';
    SourceTable = "Guarantor Substitution Header";

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
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Substitution Type"; Rec."Substitution Type")
                {
                    ApplicationArea = All;

                }

                field("Guaranteed Amount"; Rec."Guaranteed Amount")
                {
                    ApplicationArea = All;
                }
                field("Substituted Amount"; Rec."Substituted Amount")
                {
                    ApplicationArea = All;
                }
                field("Substitution Amount Collateral"; Rec."Substitution Amount Collateral")
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
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    Importance = Additional;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Importance = Additional;
                }
                field("Approved Time"; Rec."Approved Time")
                {
                    Importance = Additional;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part("Guarantor Substitution Subform"; "Guarantor Substitution Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(AttachmentFactBox; "Attachement FactBox")
            {
                ApplicationArea = All;
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
                ApplicationArea = Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Send an approval request.';
                Visible = IsVisibleSendApprovalRequest;

                /*trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    CALCFIELDS("Guaranteed Amount", "Substituted Amount"); Rec.TestField("Substituted Amount");
                    IF "Substituted Amount" < "Guaranteed Amount" THEN
                        ERROR(Error001, FIELDCAPTION("Substituted Amount"));
                    IF NOT GuarantorsLineExist THEN
                        ERROR(Error000, Rec."No.");

                    IF ApprovalsMgmt.CheckGuarantorSubstitutionApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendGuarantorSubstitutionForApproval(Rec);
                    CurrPage.CLOSE;
                end;*/
                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                    GuarantorSubstitutionLine: Record "Guarantor Substitution Line";
                    TotalGuaranteedAmount: Decimal;
                    Error002: Label 'No guarantors marked for substitution in document %1.', Comment = '%1 = Document No.';
                begin
                    Rec.CALCFIELDS("Guaranteed Amount", "Substituted Amount", "Substitution Amount Collateral");

                    // Verify that at least one guarantor is marked for substitution
                    GuarantorSubstitutionLine.RESET;
                    GuarantorSubstitutionLine.SETRANGE("Document No.", Rec."No.");
                    GuarantorSubstitutionLine.SETRANGE(Substitute, TRUE);
                    IF NOT GuarantorSubstitutionLine.FINDSET THEN
                        ERROR(Error002, Rec."No.");

                    // Calculate total guaranteed amount for marked guarantors
                    TotalGuaranteedAmount := 0;
                    REPEAT
                        TotalGuaranteedAmount += GuarantorSubstitutionLine."Guaranteed Amount";
                    UNTIL GuarantorSubstitutionLine.NEXT = 0;

                    IF Rec."Substitution Type" = Rec."Substitution Type"::Guarantor THEN BEGIN
                        Rec.TESTFIELD(Rec."Substituted Amount");
                        IF Rec."Substituted Amount" < TotalGuaranteedAmount THEN
                            ERROR(Error001, Rec.FIELDCAPTION(Rec."Substituted Amount"));
                    END ELSE BEGIN
                        Rec.TESTFIELD(Rec."Substitution Amount Collateral");
                        IF Rec."Substitution Amount Collateral" < TotalGuaranteedAmount THEN
                            ERROR(Error001, Rec.FIELDCAPTION(Rec."Substitution Amount Collateral"));
                    END;

                    IF NOT Rec.GuarantorsLineExist THEN
                        ERROR(Error000, Rec."No.");

                    IF ApprovalsMgmt.CheckGuarantorSubstitutionApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendGuarantorSubstitutionForApproval(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Visible = IsVisibleCancelApprovalRequest;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                begin
                    ApprovalsMgmt.OnCancelGuarantorSubstitutionApprovalRequest(Rec);
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
                Visible = IsVisibleApproveAction;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN begin
                        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    end;
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
                Visible = IsVisibleRejectAction;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN begin
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    end;
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
                Visible = IsVisibleDelegateAction;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN begin
                        ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                        CurrPage.CLOSE;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.AttachmentFactBox.PAGE.SetParameter(Rec.RECORDID, Rec."No.");
    end;

    trigger OnOpenPage()
    begin
        PageVisibility;
        PageEditable;
    end;

    var
        IsVisibleCancelApprovalRequest: Boolean;
        IsVisibleSendApprovalRequest: Boolean;
        IsVisiblePost: Boolean;
        IsVisibleApproveAction: Boolean;
        IsVisibleRejectAction: Boolean;
        IsVisibleDelegateAction: Boolean;
        Error000: Label 'No Guarantor Lines Exist';
        Error001: Label '%1 is not sufficient';

    local procedure PageVisibility()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleSendApprovalRequest := TRUE;
            IsVisiblePost := FALSE;
        END ELSE BEGIN
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleSendApprovalRequest := FALSE;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            IsVisibleApproveAction := TRUE;
            IsVisibleRejectAction := TRUE;
            IsVisibleDelegateAction := TRUE;
        END ELSE BEGIN
            IsVisibleApproveAction := FALSE;
            IsVisibleRejectAction := FALSE;
            IsVisibleDelegateAction := FALSE;
        END;
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            IsVisiblePost := TRUE;
        END;
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;

}

